# frozen_string_literal: true

require_relative 'goal/goal_client_read_test'
require_relative 'goal/goal_client_search_test'

module USQualityCoreTestKit
  module Client
    module USQualityCoreClientV050
      class GoalClientGroup < Inferno::TestGroup
        id :us_quality_core_client_v050_goal

        title 'Goal'

        description %(

# Background

This test group verifies that the client can access Goal data
conforming to the US Quality Core Goal Profile.

# Testing Methodology

## Data Access Supported

Clients may not be required to support the Goal FHIR resource type. However, if they
do support it, they must support the US Quality Core Goal Profile and use a supported search to access its data.
The tests in this group will not execute if client makes no attempt to access data for the
Goal resource type. In this case, the test will be marked as skip if support
for the resource type is required, and omitted otherwise.

## Reading
This test checks that the client performed a read of any Goal resource, regardless of its ID.

## Searching
The client must demonstrate at least one of the following search parameter
combinations supported by the server for Goal:

* patient


        )

        optional false

        run_as_group

        test from: :us_quality_core_v050_goal_client_read_test
        test from: :us_quality_core_v050_goal_client_search_test
      end
    end
  end
end
