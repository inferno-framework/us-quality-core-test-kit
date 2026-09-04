# frozen_string_literal: true

module USQualityCoreTestKit
  module Client
    module USQualityCoreClientV100_BALLOT
      class ObservationClinicalResultClientReadTest < Inferno::Test
        include TestHelper

        id :us_quality_core_v100_ballot_observation_clinical_result_client_read_test

        title 'SHALL support read of ObservationClinicalResult'

        description %(
          The client demonstrates SHALL support for reading ObservationClinicalResult.
        )

        def skip_message
          "Inferno did not receive any read requests for the `Observation` resource type."
        end

        def failure_message
          "Inferno did not receive the expected read request for the target instance of the US Quality Core Observation Clinical Result Profile: `Observation/usqualitycore-observation-clinical-result`, `Observation/usqualitycore-observation-lab`."
        end

        run do
          requests = load_tagged_requests(READ_OBSERVATION_TAG)
          skip_if requests.blank?, skip_message

          requests_for_id = filter_requests_by_resource_id(requests, ["usqualitycore-observation-clinical-result", "usqualitycore-observation-lab"])
          assert requests_for_id.any?, failure_message
        end
      end
    end
  end
end
