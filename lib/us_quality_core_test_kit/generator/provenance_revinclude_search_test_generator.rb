# frozen_string_literal: true

require 'us_core_test_kit/generator/provenance_revinclude_search_test_generator'

require_relative 'naming'
require_relative 'special_cases'

module USQualityCoreTestKit
  class Generator
    class ProvenanceRevincludeSearchTestGenerator < USCoreTestKit::Generator::ProvenanceRevincludeSearchTestGenerator
      def template
        @template ||= File.read(File.join(__dir__, 'templates', 'provenance_revinclude_search.rb.erb'))
      end

      def profile_identifier
        Naming.snake_case_for_profile(group_metadata)
      end

      def test_id
        "us_quality_core_#{group_metadata.reformatted_version}_#{profile_identifier}_#{search_identifier}_search_test"
      end

      def class_name
        "#{Naming.upper_camel_case_for_profile(group_metadata)}#{search_title}SearchTest"
      end

      def module_name
        "USQualityCore#{group_metadata.reformatted_version.upcase}"
      end
    end
  end
end
