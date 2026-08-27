# frozen_string_literal: true

require_relative 'naming'
require_relative 'special_cases'

module USQualityCoreTestKit
  class Generator
    class ValidationTestGenerator
      attr_accessor :group_metadata, :medication_request_metadata, :base_output_dir

      def initialize(group_metadata, medication_request_metadata = nil, base_output_dir:)
        self.group_metadata = group_metadata
        self.medication_request_metadata = medication_request_metadata
        self.base_output_dir = base_output_dir
      end

      def output
        @output ||= ERB.new(template, trim_mode: '-').result(binding)
      end

      def base_output_file_name
        "#{class_name.underscore}.rb"
      end

      def output_file_directory
        File.join(base_output_dir, directory_name)
      end

      def output_file_name
        File.join(output_file_directory, base_output_file_name)
      end

      def profile_url
        group_metadata.profile_url
      end

      def profile_name
        group_metadata.profile_name
      end

      def profile_version
        group_metadata.profile_version
      end

      def resource_type
        group_metadata.resource
      end

      def conformance_expectation
        read_interaction[:expectation]
      end

      def generate
        FileUtils.mkdir_p(output_file_directory)
        File.write(output_file_name, output)

        test_metadata = {
          id: test_id,
          file_name: base_output_file_name
        }

        if resource_type == 'Medication'
          medication_request_metadata.add_test(**test_metadata)
        else
          group_metadata.add_test(**test_metadata)
        end
      end

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
        base_description = <<~DESCRIPTION
          #{description_intro}
          It verifies the presence of mandatory elements and that elements with
          required bindings contain appropriate values. CodeableConcept element
          bindings will fail if none of their codings have a code/system belonging
          to the bound ValueSet. Quantity, Coding, and code element bindings will
          fail if their code/system are not found in the valueset.
        DESCRIPTION

        filter_note = validation_message_filter_note
        return base_description unless filter_note

        "#{base_description}\n#{filter_note}"
      end

      def validation_message_filter_note
        case resource_type
        when 'Patient'
          <<~NOTE
            Note: This test ignores validator messages for `Patient.extension`. This is a workaround for
            a known validator package interaction where CQL can load US Core 7 definitions into the
            validator session even though US Quality Core 0.5.0 is based on US Core 6.1.0.
          NOTE
        when 'DeviceRequest'
          <<~NOTE
            Note: This test ignores a known validator slicing resolution message for
            `DeviceRequest.modifierExtension`.
          NOTE
        end
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
