# frozen_string_literal: true

module USQualityCoreTestKit
  module Client
    module USQualityCoreClientV100_BALLOT
      class ServicerequestClientReadTest < Inferno::Test
        id :us_quality_core_v100_ballot_servicerequest_client_read_test

        title 'SHALL support read of ServiceRequest'

        description %(
          The client demonstrates SHALL support for reading the ServiceRequest resource type.
        )

        optional true

        def skip_message
          "Inferno did not receive any read requests for the `ServiceRequest` resource type."
        end

        run do
          requests = load_tagged_requests(READ_SERVICE_REQUEST_TAG)
          skip_if requests.blank?, skip_message
        end
      end
    end
  end
end
