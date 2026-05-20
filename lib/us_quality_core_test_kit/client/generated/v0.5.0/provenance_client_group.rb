# frozen_string_literal: true

require_relative 'provenance/provenance_client_read_test'

module USQualityCoreTestKit
  module Client
    module USQualityCoreClientV050
      class ProvenanceClientGroup < Inferno::TestGroup
        id :us_quality_core_client_v050_provenance

        title 'US Core Provenance'

        description %(

# Background

This test group verifies that the client can access Provenance data
conforming to the US Core Provenance Profile.

# Testing Methodology

## Data Access Supported

Clients may not be required to support the Provenance FHIR resource type. However, if they
do support it, they must support the US Core Provenance Profile and the resource type's search parameters.
The tests in this group will not execute if client makes no attempt to access data for the
Provenance resource type. In this case, the test will be marked as skip if support
for the resource type is required, and omitted otherwise.

## Reading
This test will check that the client performed a read of the following id:

* `us-quality-core-test-kit-provenance`

## Searching
These tests will check that the client performed searches against the
Provenance resource type with the following required parameters:



Inferno will also look for searches using the following optional parameters:




        )

        optional false

        run_as_group

        test from: :us_quality_core_v050_provenance_client_read_test
      end
    end
  end
end
