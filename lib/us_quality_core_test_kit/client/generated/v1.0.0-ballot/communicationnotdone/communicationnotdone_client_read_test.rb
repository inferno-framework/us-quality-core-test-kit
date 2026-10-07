# frozen_string_literal: true

module USQualityCoreTestKit
  module Client
    module USQualityCoreClientV100_BALLOT
      class CommunicationnotdoneClientReadTest < Inferno::Test
        id :us_quality_core_v100_ballot_communicationnotdone_client_read_test

        title 'SHALL support read of Communication'

        description %(
          The client demonstrates SHALL support for reading the Communication resource type.
        )

        optional true

        def skip_message
          "Inferno did not receive any read requests for the `Communication` resource type."
        end

        run do
          requests = load_tagged_requests(READ_COMMUNICATION_TAG)
          skip_if requests.blank?, skip_message
        end
      end
    end
  end
end
