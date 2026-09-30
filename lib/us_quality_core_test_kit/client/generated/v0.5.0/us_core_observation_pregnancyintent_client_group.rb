# frozen_string_literal: true

require_relative 'us_core_observation_pregnancyintent/us_core_observation_pregnancyintent_client_read_test'
require_relative 'us_core_observation_pregnancyintent/us_core_observation_pregnancyintent_client_search_test'

module USQualityCoreTestKit
  module Client
    module USQualityCoreClientV050
      class UsCoreObservationPregnancyintentClientGroup < Inferno::TestGroup
        id :us_quality_core_client_v050_us_core_observation_pregnancyintent

        title 'Observation US Core Pregnancy Intent'

        description %(

# Background

This test group verifies that the client can access Observation data
conforming to the US Core Observation Pregnancy Intent Profile.

# Testing Methodology

## Data Access Supported

Clients may not be required to support the Observation FHIR resource type. However, if they
do support it, they must support the US Core Observation Pregnancy Intent Profile and use a supported search to access its data.
The tests in this group will not execute if client makes no attempt to access data for the
Observation resource type. In this case, the test will be marked as skip if support
for the resource type is required, and omitted otherwise.

## Reading
This test will check that the client performed a read of the following id:

* `usqualitycore-us-core-observation-pregnancyintent`

## Searching
The client must demonstrate at least one of the following search parameter
combinations supported by the server for Observation:

* patient + code
* patient + category + status
* patient + category
* patient + category + date


        )

        optional false

        run_as_group

        test from: :us_quality_core_v050_us_core_observation_pregnancyintent_client_read_test
        test from: :us_quality_core_v050_us_core_observation_pregnancyintent_client_search_test
      end
    end
  end
end
