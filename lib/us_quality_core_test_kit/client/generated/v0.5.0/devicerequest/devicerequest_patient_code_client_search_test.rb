# frozen_string_literal: true

module USQualityCoreTestKit
  module Client
    module USQualityCoreClientV050
      class DevicerequestPatientCodeClientSearchTest < Inferno::Test
        include TestHelper

        id :us_quality_core_v050_devicerequest_patient_code_client_search_test

        title 'SHALL support patient + code search of Devicerequest'

        description %(
          The client demonstrates SHALL support for searching patient + code on Devicerequest.
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

        def all_required_search_parameters
          ["patient", "code", "do-not-perform"]
        end

        run do
          requests = load_tagged_requests(SEARCH_DEVICE_REQUEST_TAG)
          skip_if requests.blank?, skip_message

          requests_with_params = filter_requests_by_search_parameters(requests, required_params)
          assert requests_with_params.any?, failure_message

          non_required_search_parameters(requests_with_params, all_required_search_parameters).each do |parameter|
            warning "The client used the non-required search parameter `#{parameter}` for `DeviceRequest`. " \
                    'The server may not accept search parameters other than those required by the IG CapabilityStatement.'
          end
        end
      end
    end
  end
end
