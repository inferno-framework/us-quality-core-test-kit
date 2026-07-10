# frozen_string_literal: true

module USQualityCoreTestKit
  module Client
    module USQualityCoreClientV100
      class MedicationrequestedClientReadTest < Inferno::Test
        include TestHelper

        id :us_quality_core_v100_medicationrequested_client_read_test

        title 'SHALL support read of Medicationrequested'

        description %(
          The client demonstrates SHALL support for reading Medicationrequested.
        )

        def skip_message
          "Inferno did not receive any read requests for the `MedicationRequest` resource type."
        end

        def failure_message
          "Inferno did not receive the expected read request for the target instance of the US Quality Core MedicationRequested: `MedicationRequest/usqualitycore-medicationrequested`."
        end

        run do
          requests = load_tagged_requests(READ_MEDICATION_REQUEST_TAG)
          skip_if requests.blank?, skip_message

          requests_for_id = filter_requests_by_resource_id(requests, 'usqualitycore-medicationrequested')
          assert requests_for_id.any?, failure_message
        end
      end
    end
  end
end
