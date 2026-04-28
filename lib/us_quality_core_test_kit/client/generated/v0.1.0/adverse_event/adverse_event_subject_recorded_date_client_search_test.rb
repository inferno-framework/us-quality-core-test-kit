# frozen_string_literal: true

module USQualityCoreTestKit
  module Client
    module USQualityCoreClientV010
      class AdverseEventSubjectRecordedDateClientSearchTest < Inferno::Test
        include TestHelper

        id :us_quality_core_v010_adverse_event_subject_recorded_date_client_search_test

        title 'SHALL support subject + recorded-date search of AdverseEvent'

        description %(
          The client demonstrates SHALL support for searching subject + recorded-date on AdverseEvent.
        )

        optional false

        def required_params
          ["subject", "recorded-date"]
        end

        def skip_message
          "Inferno did not receive any search requests for the `AdverseEvent` resource type."
        end

        def failure_message
          "Inferno did not receive the expected search made for the `AdverseEvent` resource type with required search parameters: `#{required_params.join(' + ')}`."
        end

        run do
          requests = load_tagged_requests(SEARCH_ADVERSE_EVENT_TAG)
          skip_if requests.blank?, skip_message

          requests_with_params = filter_requests_by_search_parameters(requests, required_params)
          assert requests_with_params.any?, failure_message
        end
      end
    end
  end
end
