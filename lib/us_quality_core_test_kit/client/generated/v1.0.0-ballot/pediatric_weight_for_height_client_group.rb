# frozen_string_literal: true

require_relative 'pediatric_weight_for_height/pediatric_weight_for_height_client_read_test'
require_relative 'pediatric_weight_for_height/pediatric_weight_for_height_client_search_test'

module USQualityCoreTestKit
  module Client
    module USQualityCoreClientV100_BALLOT
      class PediatricWeightForHeightClientGroup < Inferno::TestGroup
        id :us_quality_core_client_v100_ballot_pediatric_weight_for_height

        title 'Observation US Core Pediatric Weight for Height'

        description %(

# Background

This test group verifies that the client can access Observation data
conforming to the US Core Pediatric Weight for Height Observation Profile.

# Testing Methodology

## Data Access Supported

Clients may not be required to support the Observation FHIR resource type. However, if they
do support it, they must support the US Core Pediatric Weight for Height Observation Profile and use a supported search to access its data.
The tests in this group will not execute if client makes no attempt to access data for the
Observation resource type. In this case, the test will be marked as skip if support
for the resource type is required, and omitted otherwise.

## Reading
This test checks that the client performed a read of any Observation resource, regardless of its ID.

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

        test from: :us_quality_core_v100_ballot_pediatric_weight_for_height_client_read_test
        test from: :us_quality_core_v100_ballot_pediatric_weight_for_height_client_search_test
      end
    end
  end
end
