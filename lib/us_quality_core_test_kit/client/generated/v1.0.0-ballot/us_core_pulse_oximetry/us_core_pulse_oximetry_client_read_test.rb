# frozen_string_literal: true

module USQualityCoreTestKit
  module Client
    module USQualityCoreClientV100_BALLOT
      class UsCorePulseOximetryClientReadTest < Inferno::Test
        include TestHelper

        id :us_quality_core_v100_ballot_us_core_pulse_oximetry_client_read_test

        title 'SHALL support read of UsCorePulseOximetry'

        description %(
          The client demonstrates SHALL support for reading UsCorePulseOximetry.
        )

        def skip_message
          "Inferno did not receive any read requests for the `Observation` resource type."
        end

        def failure_message
          "Inferno did not receive the expected read request for the target instance of the US Core Pulse Oximetry Profile: `Observation/usqualitycore-us-core-pulse-oximetry`."
        end

        run do
          requests = load_tagged_requests(READ_OBSERVATION_TAG)
          skip_if requests.blank?, skip_message

          requests_for_id = filter_requests_by_resource_id(requests, 'usqualitycore-us-core-pulse-oximetry')
          assert requests_for_id.any?, failure_message
        end
      end
    end
  end
end
