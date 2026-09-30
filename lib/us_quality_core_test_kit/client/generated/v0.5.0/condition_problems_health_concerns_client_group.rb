# frozen_string_literal: true

require_relative 'condition_problems_health_concerns/condition_problems_health_concerns_client_read_test'
require_relative 'condition_problems_health_concerns/condition_problems_health_concerns_client_search_test'

module USQualityCoreTestKit
  module Client
    module USQualityCoreClientV050
      class ConditionProblemsHealthConcernsClientGroup < Inferno::TestGroup
        id :us_quality_core_client_v050_condition_problems_health_concerns

        title 'Condition Problems Health Concerns'

        description %(

# Background

This test group verifies that the client can access Condition data
conforming to the US Quality Core Condition Problems Health Concerns Profile.

# Testing Methodology

## Data Access Supported

Clients may not be required to support the Condition FHIR resource type. However, if they
do support it, they must support the US Quality Core Condition Problems Health Concerns Profile and use a supported search to access its data.
The tests in this group will not execute if client makes no attempt to access data for the
Condition resource type. In this case, the test will be marked as skip if support
for the resource type is required, and omitted otherwise.

## Reading
This test will check that the client performed a read of the following id:

* `usqualitycore-condition-problems-health-concerns`

## Searching
The client must demonstrate at least one of the following search parameter
combinations supported by the server for Condition:

* patient + category
* patient
* patient + code


        )

        optional false

        run_as_group

        test from: :us_quality_core_v050_condition_problems_health_concerns_client_read_test
        test from: :us_quality_core_v050_condition_problems_health_concerns_client_search_test
      end
    end
  end
end
