# frozen_string_literal: true

module USQualityCoreTestKit
  module Client
    module USQualityCoreClientV050
      class UsCoreHeartRateClientReadTest < Inferno::Test
        include TestHelper

        id :us_quality_core_v050_us_core_heart_rate_client_read_test

        title 'SHALL support read of UsCoreHeartRate'

        description %(
          The client demonstrates SHALL support for reading UsCoreHeartRate.
        )

        def skip_message
          "Inferno did not receive any read requests for the `Observation` resource type."
        end

        def failure_message
          "Inferno did not receive the expected read request for the target instance of the US Core Heart Rate Profile: `Observation/us-quality-core-test-kit-us-core-heart-rate`."
        end

        run do
          requests = load_tagged_requests(READ_OBSERVATION_TAG)
          skip_if requests.blank?, skip_message

          requests_for_id = filter_requests_by_resource_id(requests, 'us-quality-core-test-kit-us-core-heart-rate')
          assert requests_for_id.any?, failure_message
        end
      end
    end
  end
end
