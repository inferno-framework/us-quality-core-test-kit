# frozen_string_literal: true

require_relative 'naming'
require_relative 'special_cases'

module USQualityCoreTestKit
  class Generator
    class ReferenceResolutionTestGenerator
      TARGET_PROFILE_VERSIONS_FILE_NAME = 'target_profile_versions.yml'

      attr_accessor :group_metadata, :base_output_dir

      def initialize(group_metadata, base_output_dir)
        self.group_metadata = group_metadata
        self.base_output_dir = base_output_dir
      end

      def output
        @output ||= ERB.new(template, trim_mode: '-').result(binding)
      end

      def base_output_file_name
        "#{class_name.underscore}.rb"
      end

      def output_file_directory
        File.join(base_output_dir, profile_identifier)
      end

      def output_file_name
        File.join(output_file_directory, base_output_file_name)
      end

      def resource_type
        group_metadata.resource
      end

      def resource_collection_string
        'scratch_resources[:all]'
      end

      def must_support_references
        group_metadata.must_supports[:elements]
                      .select { |element| element[:types]&.include?('Reference') }
      end

      def must_support_reference_list_string
        must_support_references
          .map { |element| "#{' ' * 8}* #{resource_type}.#{element[:path]}" }
          .uniq
          .sort
          .join("\n")
      end

      def generate
        return if must_support_references.empty?

        FileUtils.mkdir_p(output_file_directory)
        File.write(output_file_name, output)

        group_metadata.add_test(
          id: test_id,
          file_name: base_output_file_name
        )
      end

      class << self
        def generate(ig_metadata, base_output_dir)
          generate_target_profile_versions(ig_metadata, base_output_dir)

          ig_metadata.groups
                     .reject { |group| SpecialCases.exclude_group? group }
                     .each { |group| new(group, base_output_dir).generate }
        end

        def generate_target_profile_versions(ig_metadata, base_output_dir)
          File.write(File.join(base_output_dir, TARGET_PROFILE_VERSIONS_FILE_NAME),
                     YAML.dump(target_profile_versions(ig_metadata)))
        end

        # The version of each IG this suite has groups for, keyed by canonical base
        # (e.g. v0.5.0: US Quality Core 0.5.0 and US Core 6.1.0). Raises if a base has no version or more than one,
        # because its target profiles would then be validated against whichever version the validator loaded last.
        def target_profile_versions(ig_metadata)
          ig_metadata.groups
                     .map { |group| [group.profile_url.split('StructureDefinition/').first, group.profile_version] }
                     .uniq
                     .group_by(&:first)
                     .to_h do |base, pairs|
            versions = pairs.map(&:last)
            raise "Profile version is blank for #{base}" if versions.any?(&:blank?)
            raise "Multiple profile versions for #{base}: #{versions.join(', ')}" if versions.many?

            [base, versions.first]
          end
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
