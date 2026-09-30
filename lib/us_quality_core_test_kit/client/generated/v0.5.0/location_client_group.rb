# frozen_string_literal: true

require_relative 'location/location_client_read_test'

module USQualityCoreTestKit
  module Client
    module USQualityCoreClientV050
      class LocationClientGroup < Inferno::TestGroup
        id :us_quality_core_client_v050_location

        title 'Location'

        description %(

# Background

This test group verifies that the client can access Location data
conforming to the US Quality Core Location Profile.

# Testing Methodology

## Data Access Supported

Clients may not be required to support the Location FHIR resource type. However, if they
do support it, they must support the US Quality Core Location Profile and use a supported search to access its data.
The tests in this group will not execute if client makes no attempt to access data for the
Location resource type. In this case, the test will be marked as skip if support
for the resource type is required, and omitted otherwise.

## Reading
This test will check that the client performed a read of the following id:

* `usqualitycore-location`

## Searching
The client must demonstrate at least one of the following search parameter
combinations supported by the server for Location:




        )

        optional false

        run_as_group

        test from: :us_quality_core_v050_location_client_read_test
      end
    end
  end
end
