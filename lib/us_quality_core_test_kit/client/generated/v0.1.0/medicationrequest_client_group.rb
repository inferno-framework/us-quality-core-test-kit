# frozen_string_literal: true

require_relative 'medicationrequest/medicationrequest_client_read_test'
require_relative 'medicationrequest/medicationrequest_patient_intent_client_search_test'

module USQualityCoreTestKit
  module Client
    module USQualityCoreClientV010
      class MedicationrequestClientGroup < Inferno::TestGroup
        id :us_quality_core_client_v010_medicationrequest

        title 'MedicationRequest'

        description %(

# Background

This test group verifies that the client can access MedicationRequest data
conforming to the US Quality Core MedicationRequest.

# Testing Methodology

## Data Access Supported

Clients may not be required to support the MedicationRequest FHIR resource type. However, if they
do support it, they must support the US Quality Core MedicationRequest and the resource type's search parameters.
The tests in this group will not execute if client makes no attempt to access data for the
MedicationRequest resource type. In this case, the test will be marked as skip if support
for the resource type is required, and omitted otherwise.

## Reading
This test will check that the client performed a read of the following id:

* `us-quality-core-test-kit-medicationrequest`

## Searching
These tests will check that the client performed searches against the
MedicationRequest resource type with the following required parameters:

* patient + intent

Inferno will also look for searches using the following optional parameters:




        )

        optional false

        run_as_group

        test from: :us_quality_core_v010_medicationrequest_client_read_test
        test from: :us_quality_core_v010_medicationrequest_patient_intent_client_search_test
      end
    end
  end
end
