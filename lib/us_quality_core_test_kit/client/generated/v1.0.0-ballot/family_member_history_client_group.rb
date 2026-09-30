# frozen_string_literal: true

require_relative 'family_member_history/family_member_history_client_read_test'
require_relative 'family_member_history/family_member_history_client_search_test'

module USQualityCoreTestKit
  module Client
    module USQualityCoreClientV100_BALLOT
      class FamilyMemberHistoryClientGroup < Inferno::TestGroup
        id :us_quality_core_client_v100_ballot_family_member_history

        title 'US Core FamilyMemberHistory'

        description %(

# Background

This test group verifies that the client can access FamilyMemberHistory data
conforming to the US Core FamilyMemberHistory Profile.

# Testing Methodology

## Data Access Supported

Clients may not be required to support the FamilyMemberHistory FHIR resource type. However, if they
do support it, they must support the US Core FamilyMemberHistory Profile and use a supported search to access its data.
The tests in this group will not execute if client makes no attempt to access data for the
FamilyMemberHistory resource type. In this case, the test will be marked as skip if support
for the resource type is required, and omitted otherwise.

## Reading
This test will check that the client performed a read of the following id:

* `usqualitycore-family-member-history`

## Searching
The client must demonstrate at least one of the following search parameter
combinations supported by the server for FamilyMemberHistory:

* patient


        )

        optional false

        run_as_group

        test from: :us_quality_core_v100_ballot_family_member_history_client_read_test
        test from: :us_quality_core_v100_ballot_family_member_history_client_search_test
      end
    end
  end
end
