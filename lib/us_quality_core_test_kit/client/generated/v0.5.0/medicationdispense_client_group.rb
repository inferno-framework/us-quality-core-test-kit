# frozen_string_literal: true

require_relative 'medicationdispense/medicationdispense_client_read_test'
require_relative 'medicationdispense/medicationdispense_client_search_test'

module USQualityCoreTestKit
  module Client
    module USQualityCoreClientV050
      class MedicationdispenseClientGroup < Inferno::TestGroup
        id :us_quality_core_client_v050_medicationdispense

        title 'MedicationDispense'

        description %(

# Background

This test group verifies that the client can access MedicationDispense data
conforming to the US Quality Core MedicationDispense Profile.

# Testing Methodology

## Data Access Supported

Clients may not be required to support the MedicationDispense FHIR resource type. However, if they
do support it, they must support the US Quality Core MedicationDispense Profile and use a supported search to access its data.
The tests in this group will not execute if client makes no attempt to access data for the
MedicationDispense resource type. In this case, the test will be marked as skip if support
for the resource type is required, and omitted otherwise.

## Reading
This test checks that the client performed a read of any MedicationDispense resource, regardless of its ID.

## Searching
The client must demonstrate at least one of the following search parameter
combinations supported by the server for MedicationDispense:

* patient + status
* patient


        )

        optional false

        run_as_group

        test from: :us_quality_core_v050_medicationdispense_client_read_test
        test from: :us_quality_core_v050_medicationdispense_client_search_test
      end
    end
  end
end
