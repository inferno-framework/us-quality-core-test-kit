# frozen_string_literal: true

require_relative 'servicerequested/servicerequested_client_read_test'
require_relative 'servicerequested/servicerequested_client_search_test'

module USQualityCoreTestKit
  module Client
    module USQualityCoreClientV100_BALLOT
      class ServicerequestedClientGroup < Inferno::TestGroup
        id :us_quality_core_client_v100_ballot_servicerequested

        title 'ServiceRequested'

        description %(

# Background

This test group verifies that the client can access ServiceRequest data
conforming to the US Quality Core ServiceRequested Profile.

# Testing Methodology

## Data Access Supported

Clients may not be required to support the ServiceRequest FHIR resource type. However, if they
do support it, they must support the US Quality Core ServiceRequested Profile and use a supported search to access its data.
The tests in this group will not execute if client makes no attempt to access data for the
ServiceRequest resource type. In this case, the test will be marked as skip if support
for the resource type is required, and omitted otherwise.

## Reading
This test will check that the client performed a read of the following id:

* `usqualitycore-servicerequest`

## Searching
The client must demonstrate at least one of the following search parameter
combinations supported by the server for ServiceRequest:

* patient + do-not-perform
* _id
* patient
* patient + category
* patient + category + authored
* patient + code


        )

        optional false

        run_as_group

        test from: :us_quality_core_v100_ballot_servicerequested_client_read_test
        test from: :us_quality_core_v100_ballot_servicerequested_client_search_test
      end
    end
  end
end
