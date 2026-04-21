# frozen_string_literal: true

require_relative 'servicerequest/servicerequest_client_read_test'
require_relative 'servicerequest/servicerequest_patient_category_client_search_test'
require_relative 'servicerequest/servicerequest_id_client_search_test'
require_relative 'servicerequest/servicerequest_patient_client_search_test'
require_relative 'servicerequest/servicerequest_patient_category_authored_client_search_test'
require_relative 'servicerequest/servicerequest_patient_code_client_search_test'
require_relative 'servicerequest/servicerequest_patient_do_not_perform_client_search_test'

module USQualityCoreTestKit
  module Client
    module USQualityCoreClientV010
      class ServicerequestClientGroup < Inferno::TestGroup
        id :us_quality_core_client_v010_servicerequest

        title 'ServiceRequest'

        description %(

# Background

This test group verifies that the client can access ServiceRequest data
conforming to the US Quality Core ServiceRequest.

# Testing Methodology

## Data Access Supported

Clients may not be required to support the ServiceRequest FHIR resource type. However, if they
do support it, they must support the US Quality Core ServiceRequest and the resource type's search parameters.
The tests in this group will not execute if client makes no attempt to access data for the
ServiceRequest resource type. In this case, the test will be marked as skip if support
for the resource type is required, and omitted otherwise.

## Reading
This test will check that the client performed a read of the following id:

* `us-quality-core-test-kit-servicerequest`

## Searching
These tests will check that the client performed searches against the
ServiceRequest resource type with the following required parameters:

* patient + category
* _id
* patient
* patient + category + authored
* patient + code
* patient + do-not-perform

Inferno will also look for searches using the following optional parameters:




        )

        optional false

        run_as_group

        test from: :us_quality_core_v010_servicerequest_client_read_test
        test from: :us_quality_core_v010_servicerequest_patient_category_client_search_test
        test from: :us_quality_core_v010_servicerequest_id_client_search_test
        test from: :us_quality_core_v010_servicerequest_patient_client_search_test
        test from: :us_quality_core_v010_servicerequest_patient_category_authored_client_search_test
        test from: :us_quality_core_v010_servicerequest_patient_code_client_search_test
        test from: :us_quality_core_v010_servicerequest_patient_do_not_perform_client_search_test
      end
    end
  end
end
