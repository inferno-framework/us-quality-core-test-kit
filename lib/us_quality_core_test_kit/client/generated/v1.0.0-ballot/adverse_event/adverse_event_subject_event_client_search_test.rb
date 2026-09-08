# frozen_string_literal: true

module USQualityCoreTestKit
  module Client
    module USQualityCoreClientV100_BALLOT
      class AdverseEventSubjectEventClientSearchTest < Inferno::Test
        include TestHelper

        id :us_quality_core_v100_ballot_adverse_event_subject_event_client_search_test

        title 'SHALL support subject + event search of AdverseEvent'

        description %(
          The client demonstrates SHALL support for searching subject + event on AdverseEvent.
        )

        optional false

        def required_params
          ["subject", "event"]
        end

        def skip_message
          "Inferno did not receive any search requests for the `AdverseEvent` resource type."
        end

        def failure_message
          "Inferno did not receive the expected search made for the `AdverseEvent` resource type with required search parameters: `#{required_params.join(' + ')}`."
        end

        def all_required_search_parameters
          ["subject", "event", "recorded-date"]
        end

        run do
          requests = load_tagged_requests(SEARCH_ADVERSE_EVENT_TAG)
          skip_if requests.blank?, skip_message

          requests_with_params = filter_requests_by_search_parameters(requests, required_params)
          assert requests_with_params.any?, failure_message

          non_required_search_parameters(requests_with_params, all_required_search_parameters).each do |parameter|
            warning "The client used the non-required search parameter `#{parameter}` for `AdverseEvent`. " \
                    'The server may not accept search parameters other than those required by the IG CapabilityStatement.'
          end
        end
      end
    end
  end
end
