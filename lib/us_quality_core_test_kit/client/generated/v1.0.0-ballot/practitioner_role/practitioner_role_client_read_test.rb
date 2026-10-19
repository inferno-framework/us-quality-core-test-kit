# frozen_string_literal: true

module USQualityCoreTestKit
  module Client
    module USQualityCoreClientV100_BALLOT
      class PractitionerRoleClientReadTest < Inferno::Test
        id :us_quality_core_v100_ballot_practitioner_role_client_read_test

        title 'SHALL support read of PractitionerRole'

        description %(
          The client demonstrates SHALL support for reading the PractitionerRole resource type.
        )

        optional false

        def skip_message
          "Inferno did not receive any read requests for the `PractitionerRole` resource type."
        end

        run do
          requests = load_tagged_requests(READ_PRACTITIONER_ROLE_TAG)
          skip_if requests.blank?, skip_message
        end
      end
    end
  end
end
