# frozen_string_literal: true

require 'us_core_test_kit/generator/search_definition_metadata_extractor'

require_relative 'special_cases'
require_relative 'value_extractor'

module USQualityCoreTestKit
  class Generator
    class SearchDefinitionMetadataExtractor < USCoreTestKit::Generator::SearchDefinitionMetadataExtractor
      def value_extractor
        @value_extractor ||= ValueExactor.new(ig_resources, resource, profile_elements)
      end

      def paths
        @paths ||= full_paths.map { |a_path| a_path.delete_prefix("#{resource}.") }
      end

      def extensions
        @extensions ||= full_paths.filter_map do |a_path|
          url = a_path.match(/(?:modifierExtension|extension)\.where\(url='([^']+)'\)/)&.[](1)
          { url: url } if url.present?
        end.presence
      end

      def profile_element
        @profile_element ||=
          profile_elements.find { |element| full_paths.include?(element.id) } ||
          extension_value_element ||
          extension_definition&.differential&.element&.find { |element| element.id == 'Extension.value[x]' } ||
          token_choice_element
      end

      def extension_value_element
        return unless full_paths.any? { |path| path.end_with?('.value') || path.end_with?('.value[x]') }

        extension_slice = extension_slice_element
        return if extension_slice.blank?

        profile_elements.find { |element| element.id.start_with?("#{extension_slice.id}.value") }
      end

      def extension_slice_element
        extensions&.filter_map do |extension_metadata|
          profile_elements.find do |element|
            element.type.any? do |type|
              type.code == 'Extension' && Array.wrap(type.profile).include?(extension_metadata[:url])
            end
          end
        end&.first
      end

      def token_choice_element
        return unless param.type == 'token'

        profile_elements.find do |element|
          next unless element.id.include?('[x]')

          lb = element.id.split('.', 2).last&.gsub('[x]', '')
          lb && paths.any? { |path| path.start_with?(lb) }
        end
      end

      def values_from_must_support_elements(short_path)
        valid_paths = [short_path, "#{short_path}.coding.code"].to_set

        group_metadata[:must_supports][:elements]
          .filter_map { |el| el[:fixed_value].presence if valid_paths.include?(el[:path]) }
      end

      def values
        fixed_boolean_values.presence ||
          profile_category_search_values.presence ||
          super.presence ||
          category_values_from_resource_metadata.presence ||
          []
      end

      def fixed_boolean_values
        return [] unless profile_element.respond_to?(:fixedBoolean) && !profile_element.fixedBoolean.nil?

        [profile_element.fixedBoolean.to_s]
      end

      def profile_category_search_values
        return [] unless category_search?

        SpecialCases::PROFILE_CATEGORY_SEARCH_VALUES[group_metadata[:profile_url]]
      end

      def category_search?
        paths.any? { |path| path.split('.').first == 'category' }
      end

      def category_values_from_resource_metadata
        return [] unless category_search?

        value_extractor.codes_from_system_code_pair(value_extractor.values_from_resource_metadata(paths))
      end

      def type
        if profile_element.present?
          if token_choice_element
            # search is a variable type, eg. DeviceRequest.codeCodeableConcept
            # the type in search metadata is 'token'
            # we need to find the "real" data type for the target element
            token_data_types = %w[CodeableConcept Coding Identifier].to_set

            id_without_choice = token_choice_element.id.gsub('[x]', '')
            matched_path = full_paths.find { |path| path.start_with?(id_without_choice) }

            if matched_path == id_without_choice
              token_data_types.find do |type|
                token_choice_element.type.any? { |element_type| element_type.code == type }
              end
            else
              token_data_types.find { |type| matched_path&.end_with?(type) }
            end
          else
            profile_element.type.first.code
          end
        else
          # search is a variable type, eg. Condition.onsetDateTime - element
          # in profile def is Condition.onset[x]
          param.type
        end
      end
    end
  end
end
