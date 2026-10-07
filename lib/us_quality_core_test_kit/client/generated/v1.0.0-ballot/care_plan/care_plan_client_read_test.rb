# frozen_string_literal: true

module USQualityCoreTestKit
  module Client
    module USQualityCoreClientV100_BALLOT
      class CarePlanClientReadTest < Inferno::Test
        id :us_quality_core_v100_ballot_care_plan_client_read_test

        title 'SHALL support read of CarePlan'

        description %(
          The client demonstrates SHALL support for reading the CarePlan resource type.
        )

        optional true

        def skip_message
          "Inferno did not receive any read requests for the `CarePlan` resource type."
        end

        run do
          requests = load_tagged_requests(READ_CARE_PLAN_TAG)
          skip_if requests.blank?, skip_message
        end
      end
    end
  end
end
