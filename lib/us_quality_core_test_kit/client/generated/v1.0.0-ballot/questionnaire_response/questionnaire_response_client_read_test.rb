# frozen_string_literal: true

module USQualityCoreTestKit
  module Client
    module USQualityCoreClientV100_BALLOT
      class QuestionnaireResponseClientReadTest < Inferno::Test
        id :us_quality_core_v100_ballot_questionnaire_response_client_read_test

        title 'SHALL support read of QuestionnaireResponse'

        description %(
          The client demonstrates SHALL support for reading the QuestionnaireResponse resource type.
        )

        optional true

        def skip_message
          "Inferno did not receive any read requests for the `QuestionnaireResponse` resource type."
        end

        run do
          requests = load_tagged_requests(READ_QUESTIONNAIRE_RESPONSE_TAG)
          skip_if requests.blank?, skip_message
        end
      end
    end
  end
end
