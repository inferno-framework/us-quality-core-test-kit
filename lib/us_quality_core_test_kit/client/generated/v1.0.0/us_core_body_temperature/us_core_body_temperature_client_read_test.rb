# frozen_string_literal: true

module USQualityCoreTestKit
  module Client
    module USQualityCoreClientV100
      class UsCoreBodyTemperatureClientReadTest < Inferno::Test
        include TestHelper

        id :us_quality_core_v100_us_core_body_temperature_client_read_test

        title 'SHALL support read of UsCoreBodyTemperature'

        description %(
          The client demonstrates SHALL support for reading UsCoreBodyTemperature.
        )

        def skip_message
          "Inferno did not receive any read requests for the `Observation` resource type."
        end

        def failure_message
          "Inferno did not receive the expected read request for the target instance of the US Core Body Temperature Profile: `Observation/usqualitycore-us-core-body-temperature`."
        end

        run do
          requests = load_tagged_requests(READ_OBSERVATION_TAG)
          skip_if requests.blank?, skip_message

          requests_for_id = filter_requests_by_resource_id(requests, 'usqualitycore-us-core-body-temperature')
          assert requests_for_id.any?, failure_message
        end
      end
    end
  end
end
