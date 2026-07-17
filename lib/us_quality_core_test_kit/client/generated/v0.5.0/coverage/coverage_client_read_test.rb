# frozen_string_literal: true

module USQualityCoreTestKit
  module Client
    module USQualityCoreClientV050
      class CoverageClientReadTest < Inferno::Test
        include TestHelper

        id :us_quality_core_v050_coverage_client_read_test

        title 'SHALL support read of Coverage'

        description %(
          The client demonstrates SHALL support for reading Coverage.
        )

        def skip_message
          "Inferno did not receive any read requests for the `Coverage` resource type."
        end

        def failure_message
          "Inferno did not receive the expected read request for the target instance of the US Quality Core Coverage Profile: `Coverage/usqualitycore-coverage`."
        end

        run do
          requests = load_tagged_requests(READ_COVERAGE_TAG)
          skip_if requests.blank?, skip_message

          requests_for_id = filter_requests_by_resource_id(requests, 'usqualitycore-coverage')
          assert requests_for_id.any?, failure_message
        end
      end
    end
  end
end
