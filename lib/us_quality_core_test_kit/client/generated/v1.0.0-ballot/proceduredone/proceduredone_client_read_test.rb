# frozen_string_literal: true

module USQualityCoreTestKit
  module Client
    module USQualityCoreClientV100_BALLOT
      class ProceduredoneClientReadTest < Inferno::Test
        include TestHelper

        id :us_quality_core_v100_ballot_proceduredone_client_read_test

        title 'SHALL support read of Proceduredone'

        description %(
          The client demonstrates SHALL support for reading Proceduredone.
        )

        def skip_message
          "Inferno did not receive any read requests for the `Procedure` resource type."
        end

        def failure_message
          "Inferno did not receive the expected read request for the target instance of the US Quality Core Procedure Done Profile: `Procedure/usqualitycore-proceduredone`."
        end

        run do
          requests = load_tagged_requests(READ_PROCEDURE_TAG)
          skip_if requests.blank?, skip_message

          requests_for_id = filter_requests_by_resource_id(requests, 'usqualitycore-proceduredone')
          assert requests_for_id.any?, failure_message
        end
      end
    end
  end
end
