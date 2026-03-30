# frozen_string_literal: true

require 'us_core_test_kit/generator/read_test_generator'

require_relative 'naming'
require_relative 'special_cases'

module USQualityCoreTestKit
  class Generator
    class ReadTestGenerator < USCoreTestKit::Generator::ReadTestGenerator
      class << self
        def generate(ig_metadata, base_output_dir)
          ig_metadata.groups
                     .reject { |group| SpecialCases.exclude_group? group }
                     .select { |group| read_interaction(group).present? }
                     .each { |group| new(group, base_output_dir).generate }
        end

        def read_interaction(group_metadata)
          group_metadata.interactions.find { |interaction| interaction[:code] == 'read' }
        end
      end

      def template
        @template ||= File.read(File.join(__dir__, 'templates', 'read.rb.erb'))
      end

      def profile_identifier
        Naming.snake_case_for_profile(group_metadata)
      end

      def test_id
        "us_quality_core_#{group_metadata.reformatted_version}_#{profile_identifier}_read_test"
      end

      def class_name
        "#{Naming.upper_camel_case_for_profile(group_metadata)}ReadTest"
      end

      def module_name
        "USQualityCore#{group_metadata.reformatted_version.upcase}"
      end
    end
  end
end
