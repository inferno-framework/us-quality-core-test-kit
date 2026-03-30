# frozen_string_literal: true

require_relative 'organization/organization_client_read_test'

module USQualityCoreTestKit
  module Client
    module USQualityCoreClientV010
      class OrganizationClientGroup < Inferno::TestGroup
        id :us_quality_core_client_v010_organization

        title 'Organization'

        description %(

# Background

This test group verifies that the client can access Organization data
conforming to the US Quality Core Organization.

# Testing Methodology

## Data Access Supported

Clients may not be required to support the Organization FHIR resource type. However, if they
do support it, they must support the US Quality Core Organization and the resource type's search parameters.
The tests in this group will not execute if client makes no attempt to access data for the
Organization resource type. In this case, the test will be marked as skip if support
for the resource type is required, and omitted otherwise.

## Reading
This test will check that the client performed a read of the following id:

* `us-quality-core-test-kit-organization`

## Searching
These tests will check that the client performed searches against the
Organization resource type with the following required parameters:



Inferno will also look for searches using the following optional parameters:




        )

        optional false

        run_as_group

        test from: :us_quality_core_v010_organization_client_read_test
      end
    end
  end
end
