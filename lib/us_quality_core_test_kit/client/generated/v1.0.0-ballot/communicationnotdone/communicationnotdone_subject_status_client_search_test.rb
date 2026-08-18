# frozen_string_literal: true

module USQualityCoreTestKit
  module Client
    module USQualityCoreClientV100_BALLOT
      class CommunicationnotdoneSubjectStatusClientSearchTest < Inferno::Test
        include TestHelper

        id :us_quality_core_v100_ballot_communicationnotdone_subject_status_client_search_test

        title 'SHALL support subject + status search of Communicationnotdone'

        description %(
          The client demonstrates SHALL support for searching subject + status on Communicationnotdone.
        )

        optional true

        def required_params
          ["subject", "status"]
        end

        def skip_message
          "Inferno did not receive any search requests for the `Communication` resource type."
        end

        def failure_message
          "Inferno did not receive the expected search made for the `Communication` resource type with required search parameters: `#{required_params.join(' + ')}`."
        end

        run do
          requests = load_tagged_requests(SEARCH_COMMUNICATION_TAG)
          skip_if requests.blank?, skip_message

          requests_with_params = filter_requests_by_search_parameters(requests, required_params)
          assert requests_with_params.any?, failure_message
        end
      end
    end
  end
end
