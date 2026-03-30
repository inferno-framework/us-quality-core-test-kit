# frozen_string_literal: true

module USQualityCoreTestKit
  module Client
    module USQualityCoreClientV010
      class OrganizationClientReadTest < Inferno::Test
        include TestHelper

        id :us_quality_core_v010_organization_client_read_test

        title 'SHALL support read of Organization'

        description %(
          The client demonstrates SHALL support for reading Organization.
        )

        def skip_message
          "Inferno did not receive any read requests for the `Organization` resource type."
        end

        def failure_message
          "Inferno did not receive the expected read request for the target instance of the US Quality Core Organization: `Organization/us-quality-core-test-kit-organization`."
        end

        run do
          requests = load_tagged_requests(READ_ORGANIZATION_TAG)
          skip_if requests.blank?, skip_message

          requests_for_id = filter_requests_by_resource_id(requests, 'us-quality-core-test-kit-organization')
          assert requests_for_id.any?, failure_message
        end
      end
    end
  end
end
