# frozen_string_literal: true

require_relative 'value_extractor'
require_relative 'special_cases'

module USQualityCoreTestKit
  class Generator
    class SearchDefinitionMetadataExtractor
      attr_accessor :ig_resources, :name, :profile_elements, :group_metadata

      def initialize(name, ig_resources, profile_elements, group_metadata)
        self.name = name
        self.ig_resources = ig_resources
        self.profile_elements = profile_elements
        self.group_metadata = group_metadata
      end

      def search_definition
        @search_definition ||=
          {
            paths: paths,
            full_paths: full_paths,
            comparators: comparators,
            values: values,
            type: type,
            contains_multiple: contains_multiple?,
            multiple_or: multiple_or_expectation,
            chain: chain
          }.compact
      end

      def resource
        group_metadata[:resource]
      end

      def param
        @param ||= ig_resources.search_param_by_resource_and_name(resource, name)
      end

      def param_hash
        param.source_hash
      end

      def full_paths
        @full_paths ||=
          begin
            path = param.expression.gsub(/.where\(resolve\((.*)/, '').gsub('url = \'', 'url=\'')
            path = path[1..-2] if path.start_with?('(') && path.end_with?(')')
            path.scan(/[. ]as[( ]([^)]*)[)]?/).flatten.map do |as_type|
              path.gsub!(/[. ]as[( ](#{as_type}[^)]*)[)]?/, as_type.upcase_first) if as_type.present?
            end

            path.gsub!('Resource.', "#{resource}.") if path.start_with?('Resource.')

            full_paths = path.split('|')

            full_paths
          end
      end

      def remove_additional_extension_from_asserted_date(full_paths)
        full_paths.each do |full_path|
          next unless full_path.include?('http://hl7.org/fhir/StructureDefinition/condition-assertedDate')

          full_path.gsub!(/\).extension./, ').')
        end
      end

      def extension_definition
        @extension_definition ||=
          begin
            ext_definition = nil
            extensions&.each do |ext_metadata|
              ext_definition = ig_resources.profile_by_url(ext_metadata[:url])
              break if ext_definition.present?
            end
            ext_definition
          end
      end

      def comparator_expectation_extensions
        @comparator_expectation_extensions ||= param_hash['_comparator'] || []
      end

      def support_expectation(extension)
        extension['extension'].first['valueCode']
      end

      def comparator_expectation(extension)
        if extension.nil?
          'MAY'
        else
          support_expectation(extension)
        end
      end

      def comparators
        {}.tap do |comparators|
          param.comparator&.each_with_index do |comparator, index|
            comparators[comparator.to_sym] = comparator_expectation(comparator_expectation_extensions[index])
          end
        end
      end

      def contains_multiple?
        if profile_element.present?
          if profile_element.id.start_with?('Extension') && extension_definition.present?
            # Find the extension instance in a US Core profile
            target_element = profile_elements.find do |element|
              element.type.any? { |type| type.code == 'Extension' && type.profile.include?(extension_definition.url) }
            end
            target_element&.max == '*'
          else
            profile_element.max == '*'
          end
        else
          false
        end
      end

      def chain_extensions
        param_hash['_chain']
      end

      def chain_expectations
        chain_extensions.map { |extension| support_expectation(extension) }
      end

      def chain
        return nil if param.chain.blank?

        param.chain
             .zip(chain_expectations)
             .map { |chain, expectation| { chain: chain, expectation: expectation } }
      end

      def multiple_or_expectation
        param_hash['_multipleOr'] ? param_hash['_multipleOr']['extension'].first['valueCode'] : 'MAY'
      end

      def values_from_must_supports(profile_element)
        return if profile_element.nil?

        short_path = profile_element.path.split('.', 2)[1]

        values_from_must_support_slices(profile_element, short_path, true).presence ||
          values_from_must_support_slices(profile_element, short_path, false).presence ||
          values_from_must_support_elements(short_path).presence ||
          []
      end

      def values_from_must_support_slices(profile_element, short_path, mandatory_slice_only)
        group_metadata[:must_supports][:slices]
          .select { |slice| [short_path, "#{short_path}.coding"].include?(slice[:path]) }
          .map do |slice|
            slice_element = profile_elements.find { |element| slice[:slice_id] == element.id }
            next if profile_element.positive? && slice_element.none? && mandatory_slice_only

            case slice[:discriminator][:type]
            when 'patternCoding', 'patternCodeableConcept'
              slice[:discriminator][:code]
            when 'requiredBinding'
              value_extractor.codes_from_system_code_pair(slice[:discriminator][:values])
            when 'value'
              slice[:discriminator][:values]
                .select { |value| value[:path] == 'coding.code' }
                .map { |value| value[:value] }
            end
          end
          .compact.flatten
      end

      def values_from_resource_metadata(paths)
        if multiple_or_expectation == 'SHALL' || paths.any? { |path| path.downcase.include?('status') }
          value_extractor.codes_from_system_code_pair(value_extractor.values_from_resource_metadata(paths))
        else
          []
        end
      end

      EXTENSION_URL_REGEX = /(?:modifierExtension|extension)\.where\(url='([^']+)'\)/
      EXTENSION_VALUE_PATH_REGEX = /\.(?:value(?:[A-Z]\w*|\[x\])?)\z/

      def value_extractor
        @value_extractor ||= ValueExactor.new(ig_resources, resource, profile_elements)
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
        base_values =
          values_from_must_supports(profile_element).presence ||
          value_extractor.values_from_fixed_codes(profile_element, type).presence ||
          value_extractor.codes_from_value_set_binding(profile_element).presence ||
          values_from_resource_metadata(paths).presence ||
          []

        fixed_boolean_value.presence ||
          (SpecialCases::PROFILE_CATEGORY_SEARCH_VALUES[group_metadata[:profile_url]] if category_search).presence ||
          base_values.presence ||
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
