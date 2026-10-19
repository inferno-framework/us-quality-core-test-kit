# frozen_string_literal: true

module USQualityCoreTestKit
  module Client
    module USQualityCoreClientV050
      class ProvenanceClientReadTest < Inferno::Test
        id :us_quality_core_v050_provenance_client_read_test

        title 'SHALL support read of Provenance'

        description %(
          The client demonstrates SHALL support for reading the Provenance resource type.
        )

        optional false

        def skip_message
          "Inferno did not receive any read requests for the `Provenance` resource type."
        end

        run do
          requests = load_tagged_requests(READ_PROVENANCE_TAG)
          skip_if requests.blank?, skip_message
        end
      end
    end
  end
end
