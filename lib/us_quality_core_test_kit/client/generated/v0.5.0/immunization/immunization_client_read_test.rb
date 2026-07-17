# frozen_string_literal: true

module USQualityCoreTestKit
  module Client
    module USQualityCoreClientV050
      class ImmunizationClientReadTest < Inferno::Test
        include TestHelper

        id :us_quality_core_v050_immunization_client_read_test

        title 'SHALL support read of Immunization'

        description %(
          The client demonstrates SHALL support for reading Immunization.
        )

        def skip_message
          "Inferno did not receive any read requests for the `Immunization` resource type."
        end

        def failure_message
          "Inferno did not receive the expected read request for the target instance of the US Quality Core Immunization Profile: `Immunization/usqualitycore-immunization`."
        end

        run do
          requests = load_tagged_requests(READ_IMMUNIZATION_TAG)
          skip_if requests.blank?, skip_message

          requests_for_id = filter_requests_by_resource_id(requests, 'usqualitycore-immunization')
          assert requests_for_id.any?, failure_message
        end
      end
    end
  end
end
