# frozen_string_literal: true

module USQualityCoreTestKit
  module Client
    module USQualityCoreClientV050
      class UsCoreBmiClientReadTest < Inferno::Test
        include TestHelper

        id :us_quality_core_v050_us_core_bmi_client_read_test

        title 'SHALL support read of UsCoreBmi'

        description %(
          The client demonstrates SHALL support for reading UsCoreBmi.
        )

        def skip_message
          "Inferno did not receive any read requests for the `Observation` resource type."
        end

        def failure_message
          "Inferno did not receive the expected read request for the target instance of the US Core BMI Profile: `Observation/us-quality-core-test-kit-us-core-bmi`."
        end

        run do
          requests = load_tagged_requests(READ_OBSERVATION_TAG)
          skip_if requests.blank?, skip_message

          requests_for_id = filter_requests_by_resource_id(requests, 'us-quality-core-test-kit-us-core-bmi')
          assert requests_for_id.any?, failure_message
        end
      end
    end
  end
end
