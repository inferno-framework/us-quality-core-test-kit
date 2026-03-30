# frozen_string_literal: true

module USQualityCoreTestKit
  module Client
    module USQualityCoreClientV010
      class DevicenotrequestedPatientCodeClientSearchTest < Inferno::Test
        include TestHelper

        id :us_quality_core_v010_devicenotrequested_patient_code_client_search_test

        title 'SHALL support patient + code search of Devicenotrequested'

        description %(
          The client demonstrates SHALL support for searching patient + code on Devicenotrequested.
        )

        optional false

        def required_params
          ["patient", "code"]
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
