# frozen_string_literal: true

require_relative 'medicationprohibited/medicationprohibited_client_read_test'
require_relative 'medicationprohibited/medicationprohibited_client_search_test'

module USQualityCoreTestKit
  module Client
    module USQualityCoreClientV100_BALLOT
      class MedicationprohibitedClientGroup < Inferno::TestGroup
        id :us_quality_core_client_v100_ballot_medicationprohibited

        title 'MedicationRequest Medication Prohibited'

        description %(

# Background

This test group verifies that the client can access MedicationRequest data
conforming to the US Quality Core Medication Prohibited Profile.

# Testing Methodology

## Data Access Supported

Clients may not be required to support the MedicationRequest FHIR resource type. However, if they
do support it, they must support the US Quality Core Medication Prohibited Profile and use a supported search to access its data.
The tests in this group will not execute if client makes no attempt to access data for the
MedicationRequest resource type. In this case, the test will be marked as skip if support
for the resource type is required, and omitted otherwise.

## Reading
This test checks that the client performed a read of any MedicationRequest resource, regardless of its ID.

## Searching
The client must demonstrate at least one of the following search parameter
combinations supported by the server for MedicationRequest:

* patient + intent + do-not-perform
* patient + intent


        )

        optional false

        run_as_group

        test from: :us_quality_core_v100_ballot_medicationprohibited_client_read_test
        test from: :us_quality_core_v100_ballot_medicationprohibited_client_search_test
      end
    end
  end
end
