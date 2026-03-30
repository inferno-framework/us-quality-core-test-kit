# frozen_string_literal: true

require_relative 'medicationdispense/medicationdispense_client_read_test'
require_relative 'medicationdispense/medicationdispense_patient_status_client_search_test'
require_relative 'medicationdispense/medicationdispense_patient_client_search_test'

module USQualityCoreTestKit
  module Client
    module USQualityCoreClientV010
      class MedicationdispenseClientGroup < Inferno::TestGroup
        id :us_quality_core_client_v010_medicationdispense

        title 'MedicationDispense'

        description %(

# Background

This test group verifies that the client can access MedicationDispense data
conforming to the US Quality Core MedicationDispense.

# Testing Methodology

## Data Access Supported

Clients may not be required to support the MedicationDispense FHIR resource type. However, if they
do support it, they must support the US Quality Core MedicationDispense and the resource type's search parameters.
The tests in this group will not execute if client makes no attempt to access data for the
MedicationDispense resource type. In this case, the test will be marked as skip if support
for the resource type is required, and omitted otherwise.

## Reading
This test will check that the client performed a read of the following id:

* `us-quality-core-test-kit-medicationdispense`

## Searching
These tests will check that the client performed searches against the
MedicationDispense resource type with the following required parameters:

* patient + status
* patient

Inferno will also look for searches using the following optional parameters:




        )

        optional false

        run_as_group

        test from: :us_quality_core_v010_medicationdispense_client_read_test
        test from: :us_quality_core_v010_medicationdispense_patient_status_client_search_test
        test from: :us_quality_core_v010_medicationdispense_patient_client_search_test
      end
    end
  end
end
