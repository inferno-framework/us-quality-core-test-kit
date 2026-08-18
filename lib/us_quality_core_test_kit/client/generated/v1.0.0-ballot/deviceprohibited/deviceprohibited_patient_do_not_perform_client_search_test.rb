# frozen_string_literal: true

module USQualityCoreTestKit
  module Client
    module USQualityCoreClientV100_BALLOT
      class DeviceprohibitedPatientDoNotPerformClientSearchTest < Inferno::Test
        include TestHelper

        id :us_quality_core_v100_ballot_deviceprohibited_patient_do_not_perform_client_search_test

        title 'SHALL support patient + do-not-perform search of Deviceprohibited'

        description %(
          The client demonstrates SHALL support for searching patient + do-not-perform on Deviceprohibited.
        )

        optional false

        def required_params
          ["patient", "do-not-perform"]
        end

        def skip_message
          "Inferno did not receive any search requests for the `DeviceRequest` resource type."
        end

        def failure_message
          "Inferno did not receive the expected search made for the `DeviceRequest` resource type with required search parameters: `#{required_params.join(' + ')}`."
        end

        run do
          requests = load_tagged_requests(SEARCH_DEVICE_REQUEST_TAG)
          skip_if requests.blank?, skip_message

          requests_with_params = filter_requests_by_search_parameters(requests, required_params)
          assert requests_with_params.any?, failure_message
        end
      end
    end
  end
end
