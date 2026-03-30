# frozen_string_literal: true

require_relative 'encounter/encounter_client_read_test'
require_relative 'encounter/encounter_patient_client_search_test'
require_relative 'encounter/encounter_id_client_search_test'
require_relative 'encounter/encounter_patient_type_client_search_test'
require_relative 'encounter/encounter_patient_date_client_search_test'

module USQualityCoreTestKit
  module Client
    module USQualityCoreClientV010
      class EncounterClientGroup < Inferno::TestGroup
        id :us_quality_core_client_v010_encounter

        title 'Encounter'

        description %(

# Background

This test group verifies that the client can access Encounter data
conforming to the US Quality Core Encounter.

# Testing Methodology

## Data Access Supported

Clients may not be required to support the Encounter FHIR resource type. However, if they
do support it, they must support the US Quality Core Encounter and the resource type's search parameters.
The tests in this group will not execute if client makes no attempt to access data for the
Encounter resource type. In this case, the test will be marked as skip if support
for the resource type is required, and omitted otherwise.

## Reading
This test will check that the client performed a read of the following id:

* `us-quality-core-test-kit-encounter`

## Searching
These tests will check that the client performed searches against the
Encounter resource type with the following required parameters:

* patient
* _id
* patient + type
* patient + date

Inferno will also look for searches using the following optional parameters:




        )

        optional false

        run_as_group

        test from: :us_quality_core_v010_encounter_client_read_test
        test from: :us_quality_core_v010_encounter_patient_client_search_test
        test from: :us_quality_core_v010_encounter_id_client_search_test
        test from: :us_quality_core_v010_encounter_patient_type_client_search_test
        test from: :us_quality_core_v010_encounter_patient_date_client_search_test
      end
    end
  end
end
