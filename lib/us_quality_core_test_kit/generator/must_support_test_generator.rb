# frozen_string_literal: true

require 'us_core_test_kit/generator/must_support_test_generator'

require_relative 'naming'
require_relative 'special_cases'

module USQualityCoreTestKit
  class Generator
    class MustSupportTestGenerator < USCoreTestKit::Generator::MustSupportTestGenerator
      class << self
        def generate(ig_metadata, base_output_dir)
          ig_metadata.groups
                     .reject { |group| SpecialCases.exclude_group? group }
                     .each { |group| new(group, base_output_dir).generate }
        end
      end

      def template
        @template ||= File.read(File.join(__dir__, 'templates', 'must_support.rb.erb'))
      end

      def profile_identifier
        Naming.snake_case_for_profile(group_metadata)
      end

      def test_id
        "us_quality_core_#{group_metadata.reformatted_version}_#{profile_identifier}_must_support_test"
      end

      def class_name
        "#{Naming.upper_camel_case_for_profile(group_metadata)}MustSupportTest"
      end

      def module_name
        "USQualityCore#{group_metadata.reformatted_version.upcase}"
      end

      def uscdi_plus_quality_list_string
        build_must_support_list_string(true)
      end

      def build_must_support_list_string(us_quality_coreuscdi_plus_quality)
        slice_names = group_metadata.must_supports[:slices]
                                    .select { |slice| slice[:us_quality_coreuscdi_plus_quality].presence == us_quality_coreuscdi_plus_quality.presence }
                                    .map { |slice| slice[:slice_id] }

        element_names = group_metadata.must_supports[:elements]
                                      .select { |element| element[:us_quality_coreuscdi_plus_quality].presence == us_quality_coreuscdi_plus_quality.presence }
                                      .map { |element| "#{resource_type}.#{element[:path]}" }

        extension_names = group_metadata.must_supports[:extensions]
                                        .select { |extension| extension[:us_quality_coreuscdi_plus_quality].presence == us_quality_coreuscdi_plus_quality.presence }
                                        .map { |extension| extension[:id] }

        choice_names = []
        group_metadata.must_supports[:choices]&.map do |choice|
          next unless choice[:us_quality_coreuscdi_plus_quality].presence == us_quality_coreuscdi_plus_quality.presence

          combined = []
          if choice.key?(:paths)
            choice[:paths].each { |path| element_names.delete("#{resource_type}.#{path}") }
            combined << choice[:paths].map { |path| "#{resource_type}.#{path}" }.join(' or ')
          end

          if choice.key?(:extension_ids)
            choice[:extension_ids].each { |extesnion_id| extension_names.delete(extesnion_id) }
            combined << choice[:extension_ids].join(' or ')
          end

          if choice.key?(:elements)
            choice[:elements].each { |element| element_names.delete("#{resource_type}.#{element[:path]}") }
            combined << choice[:elements].map { |element|
              "#{resource_type}.#{element[:path]}:#{element[:fixed_value]}"
            }.join(' or ')
          end

          choice_names << combined.join(' or ') if combined.any?
        end || []

        (slice_names + element_names + extension_names + choice_names)
          .uniq
          .sort
          .map { |name| "#{' ' * 8}* #{name}" }
          .join("\n")
      end
    end
  end
end
