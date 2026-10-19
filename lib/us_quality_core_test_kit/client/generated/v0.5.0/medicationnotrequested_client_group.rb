# frozen_string_literal: true

require_relative 'medicationnotrequested/medicationnotrequested_client_read_test'
require_relative 'medicationnotrequested/medicationnotrequested_client_search_test'

module USQualityCoreTestKit
  module Client
    module USQualityCoreClientV050
      class MedicationnotrequestedClientGroup < Inferno::TestGroup
        id :us_quality_core_client_v050_medicationnotrequested

        title 'MedicationRequest Medication Not Requested'

        description %(

# Background

This test group verifies that the client can access MedicationRequest data
conforming to the US Quality Core Medication Not Requested Profile.

# Testing Methodology

## Data Access Supported

Clients may not be required to support the MedicationRequest FHIR resource type. However, if they
do support it, they must support the US Quality Core Medication Not Requested Profile and use a supported search to access its data.
The tests in this group will not execute if client makes no attempt to access data for the
MedicationRequest resource type. In this case, the test will be marked as skip if support
for the resource type is required, and omitted otherwise.

## Reading
This test will check that the client performed a read of the following id:

* `usqualitycore-medicationprohibited`

## Searching
The client must demonstrate at least one of the following search parameter
combinations supported by the server for MedicationRequest:

* patient + intent + do-not-perform
* patient + intent


        )

        optional false

        run_as_group

        test from: :us_quality_core_v050_medicationnotrequested_client_read_test
        test from: :us_quality_core_v050_medicationnotrequested_client_search_test
      end
    end
  end
end
