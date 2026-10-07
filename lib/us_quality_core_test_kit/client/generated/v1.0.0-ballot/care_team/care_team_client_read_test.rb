# frozen_string_literal: true

module USQualityCoreTestKit
  module Client
    module USQualityCoreClientV100_BALLOT
      class CareTeamClientReadTest < Inferno::Test
        id :us_quality_core_v100_ballot_care_team_client_read_test

        title 'SHALL support read of CareTeam'

        description %(
          The client demonstrates SHALL support for reading the CareTeam resource type.
        )

        optional true

        def skip_message
          "Inferno did not receive any read requests for the `CareTeam` resource type."
        end

        run do
          requests = load_tagged_requests(READ_CARE_TEAM_TAG)
          skip_if requests.blank?, skip_message
        end
      end
    end
  end
end
