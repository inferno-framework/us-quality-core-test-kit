# frozen_string_literal: true

module USQualityCoreTestKit
  module Client
    module USQualityCoreClientV100_BALLOT
      class UsCoreRespiratoryRateClientReadTest < Inferno::Test
        id :us_quality_core_v100_ballot_us_core_respiratory_rate_client_read_test

        title 'SHALL support read of Observation'

        description %(
          The client demonstrates SHALL support for reading the Observation resource type.
        )

        optional true

        def skip_message
          "Inferno did not receive any read requests for the `Observation` resource type."
        end

        run do
          requests = load_tagged_requests(READ_OBSERVATION_TAG)
          skip_if requests.blank?, skip_message
        end
      end
    end
  end
end
