# frozen_string_literal: true

require 'us_core_test_kit/generator/search_metadata_extractor'

require_relative 'search_definition_metadata_extractor'

module USQualityCoreTestKit
  class Generator
    class SearchMetadataExtractor < USCoreTestKit::Generator::SearchMetadataExtractor
      def search_definitions
        search_param_names.each_with_object({}) do |name, definitions|
          definitions[name.to_sym] =
            SearchDefinitionMetadataExtractor.new(name, ig_resources, profile_elements,
                                                  group_metadata).search_definition
        end
      end
    end
  end
end
