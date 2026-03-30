# frozen_string_literal: true

module USQualityCoreTestKit
  module Client
    module USQualityCoreClientV010
      class AllergyIntoleranceClientReadTest < Inferno::Test
        include TestHelper

        id :us_quality_core_v010_allergy_intolerance_client_read_test

        title 'SHALL support read of AllergyIntolerance'

        description %(
          The client demonstrates SHALL support for reading AllergyIntolerance.
        )

        def skip_message
          "Inferno did not receive any read requests for the `AllergyIntolerance` resource type."
        end

        def failure_message
          "Inferno did not receive the expected read request for the target instance of the US Quality Core AllergyIntolerance: `AllergyIntolerance/us-quality-core-test-kit-allergy-intolerance`."
        end

        run do
          requests = load_tagged_requests(READ_ALLERGY_INTOLERANCE_TAG)
          skip_if requests.blank?, skip_message

          requests_for_id = filter_requests_by_resource_id(requests, 'us-quality-core-test-kit-allergy-intolerance')
          assert requests_for_id.any?, failure_message
        end
      end
    end
  end
end
