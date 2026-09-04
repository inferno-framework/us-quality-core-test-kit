# frozen_string_literal: true

module USQualityCoreTestKit
  module Client
    module USQualityCoreClientV100_BALLOT
      class UsCoreSmokingstatusClientReadTest < Inferno::Test
        include TestHelper

        id :us_quality_core_v100_ballot_us_core_smokingstatus_client_read_test

        title 'SHALL support read of UsCoreSmokingstatus'

        description %(
          The client demonstrates SHALL support for reading UsCoreSmokingstatus.
        )

        def skip_message
          "Inferno did not receive any read requests for the `Observation` resource type."
        end

        def failure_message
          "Inferno did not receive the expected read request for the target instance of the US Core Smoking Status Observation Profile: `Observation/usqualitycore-us-core-smokingstatus`."
        end

        run do
          requests = load_tagged_requests(READ_OBSERVATION_TAG)
          skip_if requests.blank?, skip_message

          requests_for_id = filter_requests_by_resource_id(requests, 'usqualitycore-us-core-smokingstatus')
          assert requests_for_id.any?, failure_message
        end
      end
    end
  end
end
