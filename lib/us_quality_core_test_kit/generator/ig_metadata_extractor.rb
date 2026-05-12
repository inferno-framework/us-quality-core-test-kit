# frozen_string_literal: true

require 'us_core_test_kit/generator/ig_metadata_extractor'

require_relative 'ig_metadata'
require_relative 'group_metadata_extractor'
require_relative 'naming'
require_relative 'special_cases'

module USQualityCoreTestKit
  class Generator
    class IGMetadataExtractor < USCoreTestKit::Generator::IGMetadataExtractor
      CAPABILITY_STATEMENT_EXPECTATION_URL =
        'http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation'

      def initialize(ig_resources)
        super

        self.metadata = IGMetadata.new
      end

      def add_missing_supported_profiles
        add_us_core_specimen_capabilities
      end

      def add_us_core_specimen_capabilities
        return unless capability_statement_mode == 'server'
        return unless ig_resources.profile_by_url(Naming::SPECIMEN)
        return unless specimen_search_params_present?

        resources = resources_in_capability_statement
        specimen_resource = resources.find { |resource| resource.type == 'Specimen' }

        if specimen_resource.present?
          specimen_resource.supportedProfile ||= []
          return if specimen_resource.supportedProfile.any? { |profile| profile.split('|').first == Naming::SPECIMEN }

          specimen_resource.supportedProfile << Naming::SPECIMEN
        else
          resources << resources.first.class.new(specimen_resource_capability_hash)
        end
      end

      def specimen_search_params_present?
        %w[_id patient].all? do |name|
          ig_resources.search_param_by_resource_and_name('Specimen', name).present?
        end
      end

      def specimen_resource_capability_hash
        {
          'extension' => [
            expectation_extension(capability_statement_mode == 'client' ? 'SHOULD' : 'SHALL')
          ],
          'type' => 'Specimen',
          'supportedProfile' => [Naming::SPECIMEN],
          '_supportedProfile' => [
            {
              'extension' => [expectation_extension('SHALL')]
            }
          ],
          'interaction' => specimen_interactions,
          'searchParam' => specimen_search_params
        }.tap do |metadata|
          if capability_statement_mode == 'server'
            metadata['referencePolicy'] = ['resolves']
            metadata['_referencePolicy'] = [
              {
                'extension' => [expectation_extension('SHOULD')]
              }
            ]
          end
        end
      end

      def capability_statement_mode
        ig_resources.capability_statement.rest.first.mode
      end

      def expectation_extension(value_code)
        {
          'url' => CAPABILITY_STATEMENT_EXPECTATION_URL,
          'valueCode' => value_code
        }
      end

      def specimen_interactions
        {
          'create' => 'MAY',
          'search-type' => 'MAY',
          'read' => 'SHALL',
          'vread' => 'SHOULD',
          'update' => 'MAY',
          'patch' => 'MAY',
          'delete' => 'MAY',
          'history-instance' => 'SHOULD',
          'history-type' => 'MAY'
        }.map do |code, expectation|
          {
            'extension' => [expectation_extension(expectation)],
            'code' => code
          }
        end
      end

      def specimen_search_params
        [
          {
            'extension' => [expectation_extension('SHALL')],
            'name' => '_id',
            'definition' => 'http://hl7.org/fhir/us/core/SearchParameter/us-core-specimen-id',
            'type' => 'token'
          },
          {
            'extension' => [expectation_extension('SHOULD')],
            'name' => 'patient',
            'definition' => 'http://hl7.org/fhir/us/core/SearchParameter/us-core-specimen-patient',
            'type' => 'reference'
          }
        ]
      end

      def remove_extra_supported_profiles
        resources_in_capability_statement.each do |resource|
          resource.supportedProfile&.delete_if do |profile_url|
            SpecialCases::PROFILES_TO_EXCLUDE.include?(profile_url) ||
              ig_resources.profile_by_url(profile_url).nil?
          end
        end
      end

      def add_metadata_from_resources
        metadata.groups =
          resources_in_capability_statement.flat_map do |resource|
            resource.supportedProfile&.map do |supported_profile|
              # supported_profile = supported_profile.split('|').first
              next if supported_profile == 'http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaire'

              GroupMetadataExtractor.new(resource, supported_profile, metadata, ig_resources).group_metadata
            end
          end.compact

        metadata.postprocess_groups(ig_resources)
      end
    end
  end
end
