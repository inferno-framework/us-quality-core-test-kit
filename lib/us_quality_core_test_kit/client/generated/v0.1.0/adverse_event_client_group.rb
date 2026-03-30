# frozen_string_literal: true

require_relative 'adverse_event/adverse_event_client_read_test'
require_relative 'adverse_event/adverse_event_subject_client_search_test'
require_relative 'adverse_event/adverse_event_subject_event_client_search_test'
require_relative 'adverse_event/adverse_event_subject_recordeddate_client_search_test'

module USQualityCoreTestKit
  module Client
    module USQualityCoreClientV010
      class AdverseEventClientGroup < Inferno::TestGroup
        id :us_quality_core_client_v010_adverse_event

        title 'AdverseEvent'

        description %(

# Background

This test group verifies that the client can access AdverseEvent data
conforming to the US Quality Core AdverseEvent.

# Testing Methodology

## Data Access Supported

Clients may not be required to support the AdverseEvent FHIR resource type. However, if they
do support it, they must support the US Quality Core AdverseEvent and the resource type's search parameters.
The tests in this group will not execute if client makes no attempt to access data for the
AdverseEvent resource type. In this case, the test will be marked as skip if support
for the resource type is required, and omitted otherwise.

## Reading
This test will check that the client performed a read of the following id:

* `us-quality-core-test-kit-adverse-event`

## Searching
These tests will check that the client performed searches against the
AdverseEvent resource type with the following required parameters:

* subject
* subject + event
* subject + recordedDate

Inferno will also look for searches using the following optional parameters:




        )

        optional false

        run_as_group

        test from: :us_quality_core_v010_adverse_event_client_read_test
        test from: :us_quality_core_v010_adverse_event_subject_client_search_test
        test from: :us_quality_core_v010_adverse_event_subject_event_client_search_test
        test from: :us_quality_core_v010_adverse_event_subject_recordeddate_client_search_test
      end
    end
  end
end
