# frozen_string_literal: true

module USQualityCoreTestKit
  module Client
    module USQualityCoreClientV100_BALLOT
      class UsCoreDocumentreferenceClientReadTest < Inferno::Test
        include TestHelper

        id :us_quality_core_v100_ballot_us_core_documentreference_client_read_test

        title 'SHALL support read of UsCoreDocumentreference'

        description %(
          The client demonstrates SHALL support for reading UsCoreDocumentreference.
        )

        def skip_message
          "Inferno did not receive any read requests for the `DocumentReference` resource type."
        end

        def failure_message
          "Inferno did not receive the expected read request for the target instance of the US Core DocumentReference Profile: `DocumentReference/usqualitycore-us-core-documentreference`."
        end

        run do
          requests = load_tagged_requests(READ_DOCUMENT_REFERENCE_TAG)
          skip_if requests.blank?, skip_message

          requests_for_id = filter_requests_by_resource_id(requests, 'usqualitycore-us-core-documentreference')
          assert requests_for_id.any?, failure_message
        end
      end
    end
  end
end
