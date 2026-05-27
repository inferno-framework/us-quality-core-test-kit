# frozen_string_literal: true

module USQualityCoreTestKit
  module Client
    module USQualityCoreClientV050
      class PediatricWeightForHeightClientReadTest < Inferno::Test
        include TestHelper

        id :us_quality_core_v050_pediatric_weight_for_height_client_read_test

        title 'SHALL support read of PediatricWeightForHeight'

        description %(
          The client demonstrates SHALL support for reading PediatricWeightForHeight.
        )

        def skip_message
          "Inferno did not receive any read requests for the `Observation` resource type."
        end

        def failure_message
          "Inferno did not receive the expected read request for the target instance of the US Core Pediatric Weight for Height Observation Profile: `Observation/usqualitycore-pediatric-weight-for-height`."
        end

        run do
          requests = load_tagged_requests(READ_OBSERVATION_TAG)
          skip_if requests.blank?, skip_message

          requests_for_id = filter_requests_by_resource_id(requests, 'usqualitycore-pediatric-weight-for-height')
          assert requests_for_id.any?, failure_message
        end
      end
    end
  end
end
