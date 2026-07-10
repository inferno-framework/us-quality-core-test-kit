# frozen_string_literal: true

module USQualityCoreTestKit
  module Client
    module USQualityCoreClientV100
      class DevicerequestedClientReadTest < Inferno::Test
        include TestHelper

        id :us_quality_core_v100_devicerequested_client_read_test

        title 'SHALL support read of Devicerequested'

        description %(
          The client demonstrates SHALL support for reading Devicerequested.
        )

        def skip_message
          "Inferno did not receive any read requests for the `DeviceRequest` resource type."
        end

        def failure_message
          "Inferno did not receive the expected read request for the target instance of the US Quality Core DeviceRequested: `DeviceRequest/usqualitycore-devicerequested`."
        end

        run do
          requests = load_tagged_requests(READ_DEVICE_REQUEST_TAG)
          skip_if requests.blank?, skip_message

          requests_for_id = filter_requests_by_resource_id(requests, 'usqualitycore-devicerequested')
          assert requests_for_id.any?, failure_message
        end
      end
    end
  end
end
