# frozen_string_literal: true

require 'us_core_test_kit/generator/search_definition_metadata_extractor'

require_relative 'value_extractor'

module USQualityCoreTestKit
  class Generator
    class SearchDefinitionMetadataExtractor < USCoreTestKit::Generator::SearchDefinitionMetadataExtractor
      def value_extractor
        @value_extractor ||= ValueExactor.new(ig_resources, resource, profile_elements)
      end

      def profile_element
        @profile_element ||=
          profile_elements.find { |element| full_paths.include?(element.id) } ||
          extension_definition&.differential&.element&.find { |element| element.id == 'Extension.value[x]' } ||
          token_choice_element
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
              token_data_types.find { |type| token_choice_element.type.any? { |element_type| element_type.code == type } }
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
