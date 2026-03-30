# frozen_string_literal: true

require 'us_core_test_kit/generator/validation_test_generator'

require_relative 'naming'
require_relative 'special_cases'

module USQualityCoreTestKit
  class Generator
    class ValidationTestGenerator < USCoreTestKit::Generator::ValidationTestGenerator
      class << self
        def generate(ig_metadata, base_output_dir)
          ig_metadata.groups
                     .reject { |group| SpecialCases.exclude_group? group }
                     .each do |group|
            new(group, base_output_dir: base_output_dir).generate
          end
        end
      end

      def template
        @template ||= File.read(File.join(__dir__, 'templates', 'validation.rb.erb'))
      end

      def directory_name
        Naming.snake_case_for_profile(medication_request_metadata || group_metadata)
      end

      def profile_identifier
        Naming.snake_case_for_profile(group_metadata)
      end

      def test_id
        "us_quality_core_#{group_metadata.reformatted_version}_#{profile_identifier}_validation_test"
      end

      def class_name
        "#{Naming.upper_camel_case_for_profile(group_metadata)}ValidationTest"
      end

      def module_name
        "USQualityCore#{group_metadata.reformatted_version.upcase}"
      end

      def skip_if_empty
        # Return true if a system must demonstrate at least one example of the resource type.
        # This drives omit vs. skip result statuses in this test.
        resource_type != 'Medication'
      end

      def description
        <<~DESCRIPTION
          #{description_intro}
          It verifies the presence of mandatory elements and that elements with
          required bindings contain appropriate values. CodeableConcept element
          bindings will fail if none of their codings have a code/system belonging
          to the bound ValueSet. Quantity, Coding, and code element bindings will
          fail if their code/system are not found in the valueset.
        DESCRIPTION
      end

      def description_intro
        if resource_type == 'Medication'
          <<~MEDICATION_INTRO
            This test verifies resources returned from previous tests conform to
            the [#{profile_name}](#{profile_url}).
          MEDICATION_INTRO
        else
          <<~GENERIC_INTRO
            This test verifies resources returned from the first search conform to
            the [#{profile_name}](#{profile_url}).
            Systems must demonstrate at least one valid example in order to pass this test.
          GENERIC_INTRO
        end
      end
    end
  end
end
