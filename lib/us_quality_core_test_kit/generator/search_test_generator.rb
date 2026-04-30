# frozen_string_literal: true

require 'us_core_test_kit/generator/search_test_generator'

require_relative 'naming'
require_relative 'special_cases'

module USQualityCoreTestKit
  class Generator
    class SearchTestGenerator < USCoreTestKit::Generator::SearchTestGenerator
      class << self
        def generate(ig_metadata, base_output_dir)
          ig_metadata.groups
                     .reject { |group| SpecialCases.exclude_group? group }
                     .select { |group| group.searches.present? }
                     .each do |group|
            group.searches.each { |search| new(group, search, base_output_dir).generate }
          end
        end
      end

      def template
        @template ||= File.read(File.join(__dir__, 'templates', 'search.rb.erb'))
      end

      def profile_identifier
        Naming.snake_case_for_profile(group_metadata)
      end

      def needs_patient_id?
        search_metadata[:names].include?('patient') ||
          search_metadata[:names].include?('subject') ||
          (resource_type == 'Patient' && search_metadata[:names].include?('_id'))
      end

      def fixed_value_search?
        first_search? && search_metadata[:names] != ['patient'] &&
          search_metadata[:names] != ['subject'] &&
          !group_metadata.delayed? && resource_type != 'Patient'
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

      def test_medication_inclusion?
        %w[MedicationRequest MedicationDispense MedicationAdministration].include?(resource_type)
      end

      def ig_link
        Naming.ig_link(group_metadata.version)
      end

      def reference_search_description
        return '' unless test_reference_variants?

        <<~REFERENCE_SEARCH_DESCRIPTION
          This test verifies that the server supports searching by reference using
          the form `patient=[id]` as well as `patient=Patient/[id]`. The two
          different forms are expected to return the same number of results.
        REFERENCE_SEARCH_DESCRIPTION
      end

      def first_search_description
        return '' unless first_search?

        <<~FIRST_SEARCH_DESCRIPTION
          Because this is the first search of the sequence, resources in the
          response will be used for subsequent tests.
        FIRST_SEARCH_DESCRIPTION
      end

      def post_search_description
        return '' unless test_post_search?

        <<~POST_SEARCH_DESCRIPTION
          Additionally, this test will check that GET and POST search methods
          return the same number of results. Search by POST is required by the
          FHIR R4 specification.
        POST_SEARCH_DESCRIPTION
      end

      def description
        <<~DESCRIPTION.gsub(/\n{3,}/, "\n\n")
          A server #{conformance_expectation} support searching by
          #{search_param_name_string} on the #{resource_type} resource. This test
          will pass if resources are returned and match the search criteria. If
          none are returned, the test is skipped.

          #{medication_inclusion_description}
          #{reference_search_description}
          #{first_search_description}
          #{post_search_description}
        DESCRIPTION
      end
    end
  end
end
