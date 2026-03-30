# frozen_string_literal: true

module USQualityCoreTestKit
  module Client
    module USQualityCoreClientV010
      class ClaimClientReadTest < Inferno::Test
        include TestHelper

        id :us_quality_core_v010_claim_client_read_test

        title 'SHALL support read of Claim'

        description %(
          The client demonstrates SHALL support for reading Claim.
        )

        def skip_message
          "Inferno did not receive any read requests for the `Claim` resource type."
        end

        def failure_message
          "Inferno did not receive the expected read request for the target instance of the US Quality Core Claim: `Claim/us-quality-core-test-kit-claim`."
        end

        run do
          requests = load_tagged_requests(READ_CLAIM_TAG)
          skip_if requests.blank?, skip_message

          requests_for_id = filter_requests_by_resource_id(requests, 'us-quality-core-test-kit-claim')
          assert requests_for_id.any?, failure_message
        end
      end
    end
  end
end
