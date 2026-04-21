# frozen_string_literal: true

require_relative 'devicerequest/devicerequest_client_read_test'
require_relative 'devicerequest/devicerequest_patient_client_search_test'
require_relative 'devicerequest/devicerequest_patient_code_client_search_test'
require_relative 'devicerequest/devicerequest_patient_do_not_perform_client_search_test'

module USQualityCoreTestKit
  module Client
    module USQualityCoreClientV010
      class DevicerequestClientGroup < Inferno::TestGroup
        id :us_quality_core_client_v010_devicerequest

        title 'DeviceRequest'

        description %(

# Background

This test group verifies that the client can access DeviceRequest data
conforming to the US Quality Core DeviceRequest.

# Testing Methodology

## Data Access Supported

Clients may not be required to support the DeviceRequest FHIR resource type. However, if they
do support it, they must support the US Quality Core DeviceRequest and the resource type's search parameters.
The tests in this group will not execute if client makes no attempt to access data for the
DeviceRequest resource type. In this case, the test will be marked as skip if support
for the resource type is required, and omitted otherwise.

## Reading
This test will check that the client performed a read of the following id:

* `us-quality-core-test-kit-devicerequest`

## Searching
These tests will check that the client performed searches against the
DeviceRequest resource type with the following required parameters:

* patient
* patient + code
* patient + do-not-perform

Inferno will also look for searches using the following optional parameters:




        )

        optional false

        run_as_group

        test from: :us_quality_core_v010_devicerequest_client_read_test
        test from: :us_quality_core_v010_devicerequest_patient_client_search_test
        test from: :us_quality_core_v010_devicerequest_patient_code_client_search_test
        test from: :us_quality_core_v010_devicerequest_patient_do_not_perform_client_search_test
      end
    end
  end
end
