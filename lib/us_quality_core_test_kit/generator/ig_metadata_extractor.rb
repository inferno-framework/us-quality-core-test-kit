# frozen_string_literal: true

require 'us_core_test_kit/generator/ig_metadata_extractor'

require_relative 'ig_metadata'
require_relative 'group_metadata_extractor'
require_relative 'special_cases'

module USQualityCoreTestKit
  class Generator
    class IGMetadataExtractor < USCoreTestKit::Generator::IGMetadataExtractor
      def initialize(ig_resources)
        super

        self.metadata = IGMetadata.new
      end

      def add_missing_supported_profiles; end

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
