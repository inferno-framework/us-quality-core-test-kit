# frozen_string_literal: true

require_relative '../../generator/suite_generator'
require_relative '../../generator/special_cases'
require_relative '../../generator/naming'

module USQualityCoreTestKit
  module Client
    class Generator
      class SuiteGenerator < USQualityCoreTestKit::Generator::SuiteGenerator
        def template
          @template ||= File.read(File.join(__dir__, 'templates', 'suite.rb.erb'))
        end

        def output
          @output ||= ERB.new(template, trim_mode: '-').result(binding)
        end

        def base_output_file_name
          'us_quality_core_client_test_suite.rb'
        end

        def class_name
          'USQualityCoreClientTestSuite'
        end

        def module_name
          "USQualityCoreClient#{ig_metadata.reformatted_version.upcase}"
        end

        def group_ids
          groups
            .map do |group|
              "#{USQualityCoreTestKit::Generator::Naming.snake_case_for_profile(group)}ClientGroup".underscore
            end
        end

        def group_names
          group_ids.map(&:camelize)
        end

        def suite_id
          "us_quality_core_client_#{ig_metadata.reformatted_version}"
        end

        def title
          "US Quality Core Client #{ig_metadata.ig_version}"
        end

        def description
          <<~DESCRIPTION

            The US Quality Core Test Kit Client Suite tests client systems for
            conformance to the [US Quality Core Implementation Guide](#{ig_link}).

            # Scope

            These tests are a DRAFT intended to allow implementers to perform
            preliminary checks of client systems against the requirements stated
            in the US Quality Core Implementation Guide and provide feedback on the tests.
            Future versions of these tests may verify other requirements and may
            change the test verification logic.

            # Test Methodology

            Inferno simulates a US Quality Core conformant FHIR server containing
            resources for each US Quality Core profile, and provides a standard FHIR
            RESTful API implementation to search and read these resources.
            During execution, Inferno will wait for the client under test to
            issue requests and will respond to them with the requested data.
            Inferno will then evaluate the requests in aggregate to verify that
            they demonstrate that the client:

            * Retrieved a target instance for each profile.
            * Performed searches using the required search parameters and search
              parameter combinations for the profile's resource type.

            # Interpreting the Results

            These tests will check for support for requesting data for every
            US Quality Core profile.  The "Read & Search" group includes a sub-group for
            each US Quality Core profile. Groups for profiles of resources that are
            required by the US Quality Core Client CapabilityStatement are marked as
            required while groups for others are optional. Each profile group
            will be evaluated on every run through these tests, but feedback
            will only be provided on profiles of resource types that the client
            makes requests for.
            - If a client makes a request for a given resource type, support for
              all profiles of that resource type will be evaluated, meaning that
              the group for each profile of that resource type will be executed,
              checking that the client read the target instance for that profile
              and perform searches with all required search parameters and
              combinations for the resource type. The executed group will pass or
              fail and include details of the issues encountered by Inferno.
            - If a client makes no requests for a given resource type, support
              is not evaluated. If support for the resource type is required, the
              tests will be marked as skipped, forcing an overall failure.
              Otherwise, the tests will be marked as omitted on the assumption
              that the client does not support the optional resource type and
              profile represented by the group.

            The tests will not pass unless at least one profile group passes.

          DESCRIPTION
        end

        def read_and_search_description
          <<~DESCRIPTION

            During these tests, the US Quality Core client system will interact with
            Inferno's simulated US Quality Core Server and demonstrate its ability to
            perform the FHIR interactions described in the [US Quality Core Client
            CapabilityStatement](#{ig_link}/CapabilityStatement-US Quality Core-client.html).

          DESCRIPTION
        end

        def profiles_description
          groups
            .map do |group|
              profile = USQualityCoreTestKit::Generator::Naming.snake_case_for_profile(group)
              "* **[#{group.profile_name}](#{group.profile_url}|#{group.profile_version})** " \
                "(id: #{USQualityCoreTestKit::Generator::Naming.instance_id_for_profile(profile)})"
            end
            .join("\n")
        end

        def access_group_id
          "us_quality_core_client_access_group_#{ig_metadata.reformatted_version.downcase}"
        end
      end
    end
  end
end
