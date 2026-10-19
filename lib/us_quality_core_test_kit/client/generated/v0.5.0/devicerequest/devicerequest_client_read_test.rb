# frozen_string_literal: true

module USQualityCoreTestKit
  module Client
    module USQualityCoreClientV050
      class DevicerequestClientReadTest < Inferno::Test
        id :us_quality_core_v050_devicerequest_client_read_test

        title 'SHALL support read of DeviceRequest'

        description %(
          The client demonstrates SHALL support for reading the DeviceRequest resource type.
        )

        optional true

        def skip_message
          "Inferno did not receive any read requests for the `DeviceRequest` resource type."
        end

        run do
          requests = load_tagged_requests(READ_DEVICE_REQUEST_TAG)
          skip_if requests.blank?, skip_message
        end
      end
    end
  end
end
