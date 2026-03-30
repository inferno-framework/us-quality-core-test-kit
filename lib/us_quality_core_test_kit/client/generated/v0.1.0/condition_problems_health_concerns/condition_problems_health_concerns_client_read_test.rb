# frozen_string_literal: true

module USQualityCoreTestKit
  module Client
    module USQualityCoreClientV010
      class ConditionProblemsHealthConcernsClientReadTest < Inferno::Test
        include TestHelper

        id :us_quality_core_v010_condition_problems_health_concerns_client_read_test

        title 'SHALL support read of ConditionProblemsHealthConcerns'

        description %(
          The client demonstrates SHALL support for reading ConditionProblemsHealthConcerns.
        )

        def skip_message
          "Inferno did not receive any read requests for the `Condition` resource type."
        end

        def failure_message
          "Inferno did not receive the expected read request for the target instance of the US Quality Core Condition Problems Health Concerns: `Condition/us-quality-core-test-kit-condition-problems-health-concerns`."
        end

        run do
          requests = load_tagged_requests(READ_CONDITION_TAG)
          skip_if requests.blank?, skip_message

          requests_for_id = filter_requests_by_resource_id(requests, 'us-quality-core-test-kit-condition-problems-health-concerns')
          assert requests_for_id.any?, failure_message
        end
      end
    end
  end
end
