# frozen_string_literal: true

require_relative 'condition_problems_health_concerns/condition_problems_health_concerns_client_read_test'
require_relative 'condition_problems_health_concerns/condition_problems_health_concerns_patient_category_client_search_test'
require_relative 'condition_problems_health_concerns/condition_problems_health_concerns_patient_client_search_test'
require_relative 'condition_problems_health_concerns/condition_problems_health_concerns_patient_abatement_date_client_search_test'
require_relative 'condition_problems_health_concerns/condition_problems_health_concerns_patient_code_client_search_test'
require_relative 'condition_problems_health_concerns/condition_problems_health_concerns_patient_onset_date_client_search_test'

module USQualityCoreTestKit
  module Client
    module USQualityCoreClientV010
      class ConditionProblemsHealthConcernsClientGroup < Inferno::TestGroup
        id :us_quality_core_client_v010_condition_problems_health_concerns

        title 'Condition Problems Health Concerns'

        description %(

# Background

This test group verifies that the client can access Condition data
conforming to the US Quality Core Condition Problems Health Concerns.

# Testing Methodology

## Data Access Supported

Clients may not be required to support the Condition FHIR resource type. However, if they
do support it, they must support the US Quality Core Condition Problems Health Concerns and the resource type's search parameters.
The tests in this group will not execute if client makes no attempt to access data for the
Condition resource type. In this case, the test will be marked as skip if support
for the resource type is required, and omitted otherwise.

## Reading
This test will check that the client performed a read of the following id:

* `us-quality-core-test-kit-condition-problems-health-concerns`

## Searching
These tests will check that the client performed searches against the
Condition resource type with the following required parameters:

* patient + category
* patient

Inferno will also look for searches using the following optional parameters:

* patient + abatement-date
* patient + code
* patient + onset-date


        )

        optional false

        run_as_group

        test from: :us_quality_core_v010_condition_problems_health_concerns_client_read_test
        test from: :us_quality_core_v010_condition_problems_health_concerns_patient_category_client_search_test
        test from: :us_quality_core_v010_condition_problems_health_concerns_patient_client_search_test
        test from: :us_quality_core_v010_condition_problems_health_concerns_patient_abatement_date_client_search_test
        test from: :us_quality_core_v010_condition_problems_health_concerns_patient_code_client_search_test
        test from: :us_quality_core_v010_condition_problems_health_concerns_patient_onset_date_client_search_test
      end
    end
  end
end
