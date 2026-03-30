# frozen_string_literal: true

require_relative 'taskrejected/taskrejected_client_read_test'
require_relative 'taskrejected/taskrejected_patient_status_client_search_test'
require_relative 'taskrejected/taskrejected_patient_client_search_test'
require_relative 'taskrejected/taskrejected_patient_code_client_search_test'

module USQualityCoreTestKit
  module Client
    module USQualityCoreClientV010
      class TaskrejectedClientGroup < Inferno::TestGroup
        id :us_quality_core_client_v010_taskrejected

        title 'Task Rejected'

        description %(

# Background

This test group verifies that the client can access Task data
conforming to the US Quality Core Task Rejected.

# Testing Methodology

## Data Access Supported

Clients may not be required to support the Task FHIR resource type. However, if they
do support it, they must support the US Quality Core Task Rejected and the resource type's search parameters.
The tests in this group will not execute if client makes no attempt to access data for the
Task resource type. In this case, the test will be marked as skip if support
for the resource type is required, and omitted otherwise.

## Reading
This test will check that the client performed a read of the following id:

* `us-quality-core-test-kit-taskrejected`

## Searching
These tests will check that the client performed searches against the
Task resource type with the following required parameters:

* patient + status
* patient
* patient + code

Inferno will also look for searches using the following optional parameters:




        )

        optional false

        run_as_group

        test from: :us_quality_core_v010_taskrejected_client_read_test
        test from: :us_quality_core_v010_taskrejected_patient_status_client_search_test
        test from: :us_quality_core_v010_taskrejected_patient_client_search_test
        test from: :us_quality_core_v010_taskrejected_patient_code_client_search_test
      end
    end
  end
end
