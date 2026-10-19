# frozen_string_literal: true

require_relative 'encounter/encounter_client_read_test'
require_relative 'encounter/encounter_client_search_test'

module USQualityCoreTestKit
  module Client
    module USQualityCoreClientV050
      class EncounterClientGroup < Inferno::TestGroup
        id :us_quality_core_client_v050_encounter

        title 'Encounter'

        description %(

# Background

This test group verifies that the client can access Encounter data
conforming to the US Quality Core Encounter Profile.

# Testing Methodology

## Data Access Supported

Clients may not be required to support the Encounter FHIR resource type. However, if they
do support it, they must support the US Quality Core Encounter Profile and use a supported search to access its data.
The tests in this group will not execute if client makes no attempt to access data for the
Encounter resource type. In this case, the test will be marked as skip if support
for the resource type is required, and omitted otherwise.

## Reading
This test will check that the client performed a read of the following id:

* `usqualitycore-encounter`

## Searching
The client must demonstrate at least one of the following search parameter
combinations supported by the server for Encounter:

* patient
* _id
* patient + type
* patient + date


        )

        optional false

        run_as_group

        test from: :us_quality_core_v050_encounter_client_read_test
        test from: :us_quality_core_v050_encounter_client_search_test
      end
    end
  end
end
