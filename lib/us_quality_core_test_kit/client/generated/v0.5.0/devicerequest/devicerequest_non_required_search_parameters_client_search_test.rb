# frozen_string_literal: true

module USQualityCoreTestKit
  module Client
    module USQualityCoreClientV050
      class DevicerequestNonRequiredSearchParametersClientSearchTest < Inferno::Test
        include TestHelper

        id :us_quality_core_v050_devicerequest_non_required_search_parameters_client_search_test

        title 'SHOULD only use required search parameters for DeviceRequest'

        description %(
          This test warns when the client uses search parameters that are not required by the US Quality Core IG CapabilityStatement.
        )

        optional true

        def required_search_parameters
          ["patient", "do-not-perform", "code"]
        end

        run do
          requests = load_tagged_requests(SEARCH_DEVICE_REQUEST_TAG)
          skip_if requests.blank?, "Inferno did not receive any search requests for the `DeviceRequest` resource type."

          non_required_search_parameters(requests, required_search_parameters).each do |parameter|
            warning "The client used the non-required search parameter `#{parameter}` for `DeviceRequest`. " \
                    'The server may not accept search parameters other than those required by the IG CapabilityStatement.'
          end
        end
      end
    end
  end
end
