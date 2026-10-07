# frozen_string_literal: true

module USQualityCoreTestKit
  module Client
    module USQualityCoreClientV050
      class FamilyMemberHistoryClientReadTest < Inferno::Test
        id :us_quality_core_v050_family_member_history_client_read_test

        title 'SHALL support read of FamilyMemberHistory'

        description %(
          The client demonstrates SHALL support for reading the FamilyMemberHistory resource type.
        )

        optional true

        def skip_message
          "Inferno did not receive any read requests for the `FamilyMemberHistory` resource type."
        end

        run do
          requests = load_tagged_requests(READ_FAMILY_MEMBER_HISTORY_TAG)
          skip_if requests.blank?, skip_message
        end
      end
    end
  end
end
