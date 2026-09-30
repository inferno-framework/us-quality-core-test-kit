# frozen_string_literal: true

require_relative 'taskrejected/taskrejected_client_read_test'
require_relative 'taskrejected/taskrejected_client_search_test'

module USQualityCoreTestKit
  module Client
    module USQualityCoreClientV050
      class TaskrejectedClientGroup < Inferno::TestGroup
        id :us_quality_core_client_v050_taskrejected

        title 'Task Rejected'

        description %(

# Background

This test group verifies that the client can access Task data
conforming to the US Quality Core Task Rejected Profile.

# Testing Methodology

## Data Access Supported

Clients may not be required to support the Task FHIR resource type. However, if they
do support it, they must support the US Quality Core Task Rejected Profile and use a supported search to access its data.
The tests in this group will not execute if client makes no attempt to access data for the
Task resource type. In this case, the test will be marked as skip if support
for the resource type is required, and omitted otherwise.

## Reading
This test will check that the client performed a read of the following id:

* `usqualitycore-taskrejected`

## Searching
The client must demonstrate at least one of the following search parameter
combinations supported by the server for Task:

* patient + status
* patient
* patient + code


        )

        optional false

        run_as_group

        test from: :us_quality_core_v050_taskrejected_client_read_test
        test from: :us_quality_core_v050_taskrejected_client_search_test
      end
    end
  end
end
