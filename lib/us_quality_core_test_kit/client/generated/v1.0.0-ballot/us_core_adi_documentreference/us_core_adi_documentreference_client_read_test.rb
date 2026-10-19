# frozen_string_literal: true

module USQualityCoreTestKit
  module Client
    module USQualityCoreClientV100_BALLOT
      class UsCoreAdiDocumentreferenceClientReadTest < Inferno::Test
        id :us_quality_core_v100_ballot_us_core_adi_documentreference_client_read_test

        title 'SHALL support read of DocumentReference'

        description %(
          The client demonstrates SHALL support for reading the DocumentReference resource type.
        )

        optional true

        def skip_message
          "Inferno did not receive any read requests for the `DocumentReference` resource type."
        end

        run do
          requests = load_tagged_requests(READ_DOCUMENT_REFERENCE_TAG)
          skip_if requests.blank?, skip_message
        end
      end
    end
  end
end
