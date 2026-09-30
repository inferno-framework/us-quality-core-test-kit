# frozen_string_literal: true

require_relative 'us_core_adi_documentreference/us_core_adi_documentreference_client_read_test'
require_relative 'us_core_adi_documentreference/us_core_adi_documentreference_client_search_test'

module USQualityCoreTestKit
  module Client
    module USQualityCoreClientV100_BALLOT
      class UsCoreAdiDocumentreferenceClientGroup < Inferno::TestGroup
        id :us_quality_core_client_v100_ballot_us_core_adi_documentreference

        title 'DocumentReference US Core ADI'

        description %(

# Background

This test group verifies that the client can access DocumentReference data
conforming to the US Core ADI DocumentReference Profile.

# Testing Methodology

## Data Access Supported

Clients may not be required to support the DocumentReference FHIR resource type. However, if they
do support it, they must support the US Core ADI DocumentReference Profile and use a supported search to access its data.
The tests in this group will not execute if client makes no attempt to access data for the
DocumentReference resource type. In this case, the test will be marked as skip if support
for the resource type is required, and omitted otherwise.

## Reading
This test will check that the client performed a read of the following id:

* `usqualitycore-us-core-adi-documentreference`

## Searching
The client must demonstrate at least one of the following search parameter
combinations supported by the server for DocumentReference:

* patient + category
* patient
* _id
* patient + type
* patient + category + date


        )

        optional false

        run_as_group

        test from: :us_quality_core_v100_ballot_us_core_adi_documentreference_client_read_test
        test from: :us_quality_core_v100_ballot_us_core_adi_documentreference_client_search_test
      end
    end
  end
end
