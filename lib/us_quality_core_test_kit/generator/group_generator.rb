# frozen_string_literal: true

require 'us_core_test_kit/generator/group_generator'

require_relative 'naming'
require_relative 'special_cases'

module USQualityCoreTestKit
  class Generator
    class GroupGenerator < USCoreTestKit::Generator::GroupGenerator
      class << self
        def generate(ig_metadata, base_output_dir)
          ig_metadata.ordered_groups
                     .reject { |group| SpecialCases.exclude_group? group }
                     .each { |group| new(group, base_output_dir).generate }
        end
      end

      def template
        @template ||= File.read(File.join(__dir__, 'templates', 'group.rb.erb'))
      end

      def class_name
        "#{Naming.upper_camel_case_for_profile(group_metadata)}Group"
      end

      def module_name
        "USQualityCore#{group_metadata.reformatted_version.upcase}"
      end

      def profile_identifier
        Naming.snake_case_for_profile(group_metadata)
      end

      def group_id
        "us_quality_core_#{group_metadata.reformatted_version}_#{profile_identifier}"
      end

      def search_validation_resource_type
        "#{resource_type} resources"
      end

      def optional?
        SpecialCases::OPTIONAL_RESOURCES.include?(resource_type) || group_metadata.optional_profile?
      end

      def add_special_tests; end

      def required_searches
        group_metadata.searches.select { |search| search[:expectation] == 'SHALL' }
      end

      def search_param_name_string
        required_searches
          .map { |search| search[:names].join(' + ') }
          .map { |names| "* #{names}" }
          .join("\n")
      end

      def description
        <<~DESCRIPTION
          # Background

          These tests verify that the system under test is able to provide correct
          responses for #{resource_type} queries. These queries must contain resources
          conforming to the #{profile_name} as specified in the US Quality Core Implementation Guide.

          # Testing Methodology
          #{search_description}

          ## Must Support
          Each profile contains elements marked as "must support" or with
          "USCDI+ Quality" tags. This test sequence expects to see each of these
          elements at least once. If at least one cannot be found, the test will
          fail. The test will look through the #{resource_type} resources found
          in the first test for these elements.

          ## Profile Validation
          Each resource returned from the first search is expected to conform to
          the [#{profile_name} Profile](#{profile_url}). Each element is checked against
          teminology binding and cardinality requirements.

          Elements with a required binding are validated against their bound
          ValueSet. If the code/system in the element is not part of the ValueSet,
          then the test will fail.

          ## Reference Validation
          At least one instance of each external reference in elements marked as
          "must support" within the resources provided by the system must resolve.
          The test will attempt to read each reference found and will fail if no
          read succeeds.
        DESCRIPTION
      end

      def search_description
        return '' if required_searches.blank?

        <<~SEARCH_DESCRIPTION
          ## Searching
          This test sequence will first perform each required search associated
          with this resource. This sequence will perform searches with the
          following parameters:

          #{search_param_name_string}

          ### Search Parameters
          The first search uses the selected patient(s) from the prior launch
          sequence. Any subsequent searches will look for its parameter values
          from the results of the first search. For example, the `identifier`
          search in the patient sequence is performed by looking for an existing
          `Patient.identifier` from any of the resources returned in the `_id`
          search. If a value cannot be found this way, the search is skipped.

          ### Search Validation
          Inferno will retrieve up to the first 20 bundle pages of the reply for
          #{search_validation_resource_type} and save them for subsequent tests. Each of
          these resources is then checked to see if it matches the searched
          parameters in accordance with [FHIR search
          guidelines](https://www.hl7.org/fhir/search.html). The test will fail,
          for example, if a Patient search for `gender=male` returns a `female`
          patient.
        SEARCH_DESCRIPTION
      end
    end
  end
end
