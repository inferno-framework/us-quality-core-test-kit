# frozen_string_literal: true

require 'us_core_test_kit/generator/group_metadata_extractor'

require_relative 'group_metadata'
require_relative 'special_cases'
require_relative 'naming'
require_relative 'search_metadata_extractor'
require_relative 'terminology_binding_metadata_extractor'
require_relative 'must_support_metadata_extractor'

require_relative 'ig_metadata'

module USQualityCoreTestKit
  class Generator
    class GroupMetadataExtractor < USCoreTestKit::Generator::GroupMetadataExtractor
      def group_metadata
        @group_metadata ||=
          GroupMetadata.new(group_metadata_hash)
      end

      def category_first_profile?
        SpecialCases::ALL_VERSION_CATEGORY_FIRST_PROFILES.include?(profile_url) ||
          SpecialCases::VERSION_SPECIFIC_CATEGORY_FIRST_PROFILES[profile_url]&.include?(reformatted_version)
      end

      def first_search_params
        @first_search_params ||=
          if category_first_profile?
            %w[patient category]
          elsif %w[Observation].include?(resource)
            %w[patient code]
          elsif resource == 'MedicationRequest'
            %w[patient intent]
          elsif %w[CareTeam Immunization MedicationAdministration MedicationDispense Procedure Task].include?(resource)
            %w[patient status]
          else
            ['patient']
          end
      end

      def class_name
        base_name
          .split('-')
          .map(&:capitalize)
          .join
          .gsub('UsQualityCore', "USQualityCore#{ig_metadata.reformatted_version}")
          .concat('Sequence')
      end

      def title
        title = profile.title.gsub(/US\sQuality\s*Core\s*/, '').gsub(/\s*Profile/, '').strip

        title = "#{resource} #{title.split(resource).map(&:strip).join(' ')}" if Naming.resources_with_multiple_profiles.include?(resource) && !title.start_with?(resource)

        title
      end

      def short_description
        "Verify support for the capabilities required by the #{profile_name}."
      end

      def mark_mandatory_and_must_support_searches
        searches.each do |search|
          search[:names_not_must_support_or_mandatory] = search[:names].reject do |name|
            full_paths = search_definitions[name.to_sym][:full_paths]
            any_must_support_elements = must_supports[:elements].any? do |element|
              full_must_support_paths = ["#{resource}.#{element[:original_path]}", "#{resource}.#{element[:path]}"]
              full_must_support_path_without_choice = "#{resource}.#{element[:path]}".gsub('[x]', '')

              full_paths.any? do |path|
                # allow for non-choice, choice types, and _id
                name == '_id' || full_must_support_paths.include?(path) || full_must_support_paths.include?("#{path}[x]") ||
                  (element[:path].end_with?('[x]') && path.include?(full_must_support_path_without_choice))
              end
            end

            any_must_support_slices = must_supports[:slices].any? do |slice|
              # only handle type slices because that is all we need for now
              # for a slice like Observation.effective[x]:effectiveDateTime, the search parameter's expression could be
              # either Observation.effective or Observation.effectiveDateTime.
              if slice[:discriminator] && slice[:discriminator][:type] == 'type'
                full_must_support_path = "#{resource}.#{slice[:path].sub('[x]', slice[:discriminator][:code])}"
                base_must_support_path = "#{resource}.#{slice[:path].sub('[x]', '')}"

                full_paths.intersection([full_must_support_path, base_must_support_path]).present?
              else
                false
              end
            end

            any_mandatory_elements = mandatory_elements.any? do |element|
              full_paths.include?(element)
            end

            any_must_support_elements || any_must_support_slices || any_mandatory_elements
          end

          search[:must_support_or_mandatory] = search[:names_not_must_support_or_mandatory].empty?
        end
      end

      def search_metadata_extractor
        @search_metadata_extractor ||= SearchMetadataExtractor.new(
          resource_capabilities,
          ig_resources,
          profile_elements,
          {
            resource: resource,
            profile_url: profile_url,
            must_supports: must_supports
          }
        )
      end

      def terminology_binding_metadata_extractor
        @terminology_binding_metadata_extractor ||=
          TerminologyBindingMetadataExtractor.new(profile_elements, ig_resources, resource)
      end

      def must_support_metadata_extractor
        @must_support_metadata_extractor ||=
          MustSupportMetadataExtractor.new(profile_elements, profile, resource, ig_resources)
      end
    end
  end
end
