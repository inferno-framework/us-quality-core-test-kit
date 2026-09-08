# frozen_string_literal: true

require_relative 'us_core_blood_pressure/us_core_blood_pressure_client_read_test'
require_relative 'us_core_blood_pressure/us_core_blood_pressure_patient_code_client_search_test'
require_relative 'us_core_blood_pressure/us_core_blood_pressure_patient_category_status_client_search_test'
require_relative 'us_core_blood_pressure/us_core_blood_pressure_patient_category_client_search_test'
require_relative 'us_core_blood_pressure/us_core_blood_pressure_patient_category_date_client_search_test'

module USQualityCoreTestKit
  module Client
    module USQualityCoreClientV100_BALLOT
      class UsCoreBloodPressureClientGroup < Inferno::TestGroup
        id :us_quality_core_client_v100_ballot_us_core_blood_pressure

        title 'Observation US Core Blood Pressure'

        description %(

# Background

This test group verifies that the client can access Observation data
conforming to the US Core Blood Pressure Profile.

# Testing Methodology

## Data Access Supported

Clients may not be required to support the Observation FHIR resource type. However, if they
do support it, they must support the US Core Blood Pressure Profile and the resource type's search parameters.
The tests in this group will not execute if client makes no attempt to access data for the
Observation resource type. In this case, the test will be marked as skip if support
for the resource type is required, and omitted otherwise.

## Reading
This test will check that the client performed a read of the following id:

* `usqualitycore-us-core-blood-pressure`

## Searching
These tests will check that the client performed searches against the
Observation resource type with the following required parameters:

* patient + code
* patient + category + status
* patient + category
* patient + category + date

Inferno will also look for searches using the following optional parameters:




        )

        optional false

        run_as_group

        test from: :us_quality_core_v100_ballot_us_core_blood_pressure_client_read_test
        test from: :us_quality_core_v100_ballot_us_core_blood_pressure_patient_code_client_search_test
        test from: :us_quality_core_v100_ballot_us_core_blood_pressure_patient_category_status_client_search_test
        test from: :us_quality_core_v100_ballot_us_core_blood_pressure_patient_category_client_search_test
        test from: :us_quality_core_v100_ballot_us_core_blood_pressure_patient_category_date_client_search_test
      end
    end
  end
end
