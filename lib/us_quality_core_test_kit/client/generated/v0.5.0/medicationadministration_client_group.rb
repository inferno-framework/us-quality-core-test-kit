# frozen_string_literal: true

require_relative 'medicationadministration/medicationadministration_client_read_test'
require_relative 'medicationadministration/medicationadministration_client_search_test'

module USQualityCoreTestKit
  module Client
    module USQualityCoreClientV050
      class MedicationadministrationClientGroup < Inferno::TestGroup
        id :us_quality_core_client_v050_medicationadministration

        title 'MedicationAdministration'

        description %(

# Background

This test group verifies that the client can access MedicationAdministration data
conforming to the US Quality Core MedicationAdministration Profile.

# Testing Methodology

## Data Access Supported

Clients may not be required to support the MedicationAdministration FHIR resource type. However, if they
do support it, they must support the US Quality Core MedicationAdministration Profile and use a supported search to access its data.
The tests in this group will not execute if client makes no attempt to access data for the
MedicationAdministration resource type. In this case, the test will be marked as skip if support
for the resource type is required, and omitted otherwise.

## Reading
This test will check that the client performed a read of the following id:

* `usqualitycore-medicationadministration`

## Searching
The client must demonstrate at least one of the following search parameter
combinations supported by the server for MedicationAdministration:

* patient + status
* patient
* patient + code
* patient + effective-time


        )

        optional false

        run_as_group

        test from: :us_quality_core_v050_medicationadministration_client_read_test
        test from: :us_quality_core_v050_medicationadministration_client_search_test
      end
    end
  end
end
