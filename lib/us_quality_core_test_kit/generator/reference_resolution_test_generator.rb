# frozen_string_literal: true

require 'us_core_test_kit/generator/reference_resolution_test_generator'

require_relative 'naming'
require_relative 'special_cases'

module USQualityCoreTestKit
  class Generator
    class ReferenceResolutionTestGenerator < USCoreTestKit::Generator::ReferenceResolutionTestGenerator
      class << self
        def generate(ig_metadata, base_output_dir)
          ig_metadata.groups
                     .reject { |group| SpecialCases.exclude_group? group }
                     .each { |group| new(group, base_output_dir).generate }
        end
      end

      def template
        @template ||= File.read(File.join(__dir__, 'templates', 'reference_resolution.rb.erb'))
      end

      def profile_identifier
        Naming.snake_case_for_profile(group_metadata)
      end

      def test_id
        "us_quality_core_#{group_metadata.reformatted_version}_#{profile_identifier}_reference_resolution_test"
      end

      def class_name
        "#{Naming.upper_camel_case_for_profile(group_metadata)}ReferenceResolutionTest"
      end

      def module_name
        "USQualityCore#{group_metadata.reformatted_version.upcase}"
      end
    end
  end
end
