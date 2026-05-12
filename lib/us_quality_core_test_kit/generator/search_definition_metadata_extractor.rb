# frozen_string_literal: true

require 'us_core_test_kit/generator/search_definition_metadata_extractor'

require_relative 'special_cases'
require_relative 'value_extractor'

module USQualityCoreTestKit
  class Generator
    class SearchDefinitionMetadataExtractor < USCoreTestKit::Generator::SearchDefinitionMetadataExtractor
      EXTENSION_URL_REGEX = /(?:modifierExtension|extension)\.where\(url='([^']+)'\)/
      EXTENSION_VALUE_PATH_REGEX = /\.(?:value(?:[A-Z]\w*|\[x\])?)\z/

      def value_extractor
        @value_extractor ||= ValueExactor.new(ig_resources, resource, profile_elements)
      end

      def param_hash
        return param.source_hash if param.respond_to?(:source_hash)

        param.to_hash
      end

      def chain_extensions
        param_hash['_chain'] || []
      end

      def paths
        @paths ||= full_paths.map { |a_path| a_path.delete_prefix("#{resource}.") }
      end

      def extensions
        @extensions ||= full_paths.filter_map do |a_path|
          url = a_path.match(EXTENSION_URL_REGEX)&.[](1)
          { url: url } if url.present?
        end.presence
      end

      def profile_element
        @profile_element ||= begin
          extension_value_element =
            if full_paths.any? { |path| path.match?(EXTENSION_VALUE_PATH_REGEX) }
              extension_slice =
                extensions&.lazy&.filter_map do |extension_metadata|
                  profile_elements.find do |element|
                    element.type.any? do |type|
                      type.code == 'Extension' && Array.wrap(type.profile).include?(extension_metadata[:url])
                    end
                  end
                end&.first

              profile_elements.find { |element| element.id.start_with?("#{extension_slice.id}.value") } if extension_slice
            end

          profile_elements.find { |element| full_paths.include?(element.id) } ||
            extension_value_element ||
            extension_definition&.differential&.element&.find { |element| element.id == 'Extension.value[x]' } ||
            token_choice_element
        end
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
        category_search = paths.any? { |path| path.split('.').first == 'category' }
        fixed_boolean = profile_element.fixedBoolean if profile_element.respond_to?(:fixedBoolean)
        fixed_boolean_value = [fixed_boolean.to_s] unless fixed_boolean.nil?

        fixed_boolean_value.presence ||
          (SpecialCases::PROFILE_CATEGORY_SEARCH_VALUES[group_metadata[:profile_url]] if category_search).presence ||
          super.presence ||
          (value_extractor.codes_from_system_code_pair(value_extractor.values_from_resource_metadata(paths)) if category_search).presence ||
          []
      end

      def type
        return param.type if profile_element.blank?

        choice_element = token_choice_element
        return profile_element.type.first.code if choice_element.blank?

        token_data_types = %w[CodeableConcept Coding Identifier].to_set
        id_without_choice = choice_element.id.gsub('[x]', '')
        matched_path = full_paths.find { |path| path.start_with?(id_without_choice) }

        if matched_path == id_without_choice
          token_data_types.find { |type| choice_element.type.any? { |element_type| element_type.code == type } }
        else
          token_data_types.find { |type| matched_path&.end_with?(type) }
        end
      end
    end
  end
end
