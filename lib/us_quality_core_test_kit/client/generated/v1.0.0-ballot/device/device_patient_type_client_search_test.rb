# frozen_string_literal: true

module USQualityCoreTestKit
  module Client
    module USQualityCoreClientV100_BALLOT
      class DevicePatientTypeClientSearchTest < Inferno::Test
        include TestHelper

        id :us_quality_core_v100_ballot_device_patient_type_client_search_test

        title 'SHALL support patient + type search of Device'

        description %(
          The client demonstrates SHALL support for searching patient + type on Device.
        )

        optional false

        def required_params
          ["patient", "type"]
        end

        def skip_message
          "Inferno did not receive any search requests for the `Device` resource type."
        end

        def failure_message
          "Inferno did not receive the expected search made for the `Device` resource type with required search parameters: `#{required_params.join(' + ')}`."
        end

        run do
          requests = load_tagged_requests(SEARCH_DEVICE_TAG)
          skip_if requests.blank?, skip_message

          requests_with_params = filter_requests_by_search_parameters(requests, required_params)
          assert requests_with_params.any?, failure_message
        end
      end
    end
  end
end
