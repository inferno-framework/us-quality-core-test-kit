# frozen_string_literal: true

module USQualityCoreTestKit
  module Client
    module USQualityCoreClientV100
      class DeviceprohibitedClientReadTest < Inferno::Test
        include TestHelper

        id :us_quality_core_v100_deviceprohibited_client_read_test

        title 'SHALL support read of Deviceprohibited'

        description %(
          The client demonstrates SHALL support for reading Deviceprohibited.
        )

        def skip_message
          "Inferno did not receive any read requests for the `DeviceRequest` resource type."
        end

        def failure_message
          "Inferno did not receive the expected read request for the target instance of the US Quality Core Device Prohibited: `DeviceRequest/usqualitycore-deviceprohibited`."
        end

        run do
          requests = load_tagged_requests(READ_DEVICE_REQUEST_TAG)
          skip_if requests.blank?, skip_message

          requests_for_id = filter_requests_by_resource_id(requests, 'usqualitycore-deviceprohibited')
          assert requests_for_id.any?, failure_message
        end
      end
    end
  end
end
