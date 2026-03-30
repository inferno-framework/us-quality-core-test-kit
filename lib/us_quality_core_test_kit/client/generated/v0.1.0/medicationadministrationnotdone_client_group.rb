# frozen_string_literal: true

require_relative 'medicationadministrationnotdone/medicationadministrationnotdone_client_read_test'
require_relative 'medicationadministrationnotdone/medicationadministrationnotdone_patient_status_client_search_test'
require_relative 'medicationadministrationnotdone/medicationadministrationnotdone_patient_client_search_test'
require_relative 'medicationadministrationnotdone/medicationadministrationnotdone_patient_code_client_search_test'
require_relative 'medicationadministrationnotdone/medicationadministrationnotdone_patient_effective_time_client_search_test'

module USQualityCoreTestKit
  module Client
    module USQualityCoreClientV010
      class MedicationadministrationnotdoneClientGroup < Inferno::TestGroup
        id :us_quality_core_client_v010_medicationadministrationnotdone

        title 'MedicationAdministration Not Done'

        description %(

# Background

This test group verifies that the client can access MedicationAdministration data
conforming to the US Quality Core MedicationAdministration Not Done.

# Testing Methodology

## Data Access Supported

Clients may not be required to support the MedicationAdministration FHIR resource type. However, if they
do support it, they must support the US Quality Core MedicationAdministration Not Done and the resource type's search parameters.
The tests in this group will not execute if client makes no attempt to access data for the
MedicationAdministration resource type. In this case, the test will be marked as skip if support
for the resource type is required, and omitted otherwise.

## Reading
This test will check that the client performed a read of the following id:

* `us-quality-core-test-kit-medicationadministrationnotdone`

## Searching
These tests will check that the client performed searches against the
MedicationAdministration resource type with the following required parameters:

* patient + status
* patient
* patient + code
* patient + effective-time

Inferno will also look for searches using the following optional parameters:




        )

        optional false

        run_as_group

        test from: :us_quality_core_v010_medicationadministrationnotdone_client_read_test
        test from: :us_quality_core_v010_medicationadministrationnotdone_patient_status_client_search_test
        test from: :us_quality_core_v010_medicationadministrationnotdone_patient_client_search_test
        test from: :us_quality_core_v010_medicationadministrationnotdone_patient_code_client_search_test
        test from: :us_quality_core_v010_medicationadministrationnotdone_patient_effective_time_client_search_test
      end
    end
  end
end
