# frozen_string_literal: true

require_relative 'nutrition_order/nutrition_order_client_read_test'
require_relative 'nutrition_order/nutrition_order_patient_client_search_test'

module USQualityCoreTestKit
  module Client
    module USQualityCoreClientV100
      class NutritionOrderClientGroup < Inferno::TestGroup
        id :us_quality_core_client_v100_nutrition_order

        title 'NutritionOrder'

        description %(

# Background

This test group verifies that the client can access NutritionOrder data
conforming to the US Quality Core NutritionOrder.

# Testing Methodology

## Data Access Supported

Clients may not be required to support the NutritionOrder FHIR resource type. However, if they
do support it, they must support the US Quality Core NutritionOrder and the resource type's search parameters.
The tests in this group will not execute if client makes no attempt to access data for the
NutritionOrder resource type. In this case, the test will be marked as skip if support
for the resource type is required, and omitted otherwise.

## Reading
This test will check that the client performed a read of the following id:

* `usqualitycore-nutrition-order`

## Searching
These tests will check that the client performed searches against the
NutritionOrder resource type with the following required parameters:

* patient

Inferno will also look for searches using the following optional parameters:




        )

        optional false

        run_as_group

        test from: :us_quality_core_v100_nutrition_order_client_read_test
        test from: :us_quality_core_v100_nutrition_order_patient_client_search_test
      end
    end
  end
end
