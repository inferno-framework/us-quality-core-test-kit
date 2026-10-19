# frozen_string_literal: true

require_relative 'practitioner_role/practitioner_role_client_read_test'

module USQualityCoreTestKit
  module Client
    module USQualityCoreClientV050
      class PractitionerRoleClientGroup < Inferno::TestGroup
        id :us_quality_core_client_v050_practitioner_role

        title 'PractitionerRole'

        description %(

# Background

This test group verifies that the client can access PractitionerRole data
conforming to the US Quality Core PractitionerRole Profile.

# Testing Methodology

## Data Access Supported

Clients may not be required to support the PractitionerRole FHIR resource type. However, if they
do support it, they must support the US Quality Core PractitionerRole Profile and use a supported search to access its data.
The tests in this group will not execute if client makes no attempt to access data for the
PractitionerRole resource type. In this case, the test will be marked as skip if support
for the resource type is required, and omitted otherwise.

## Reading
This test checks that the client performed a read of any PractitionerRole resource, regardless of its ID.

## Searching
The client must demonstrate at least one of the following search parameter
combinations supported by the server for PractitionerRole:




        )

        optional false

        run_as_group

        test from: :us_quality_core_v050_practitioner_role_client_read_test
      end
    end
  end
end
