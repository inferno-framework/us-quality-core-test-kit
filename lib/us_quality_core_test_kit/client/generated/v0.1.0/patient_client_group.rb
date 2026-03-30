# frozen_string_literal: true

require_relative 'patient/patient_client_read_test'
require_relative 'patient/patient_id_client_search_test'

module USQualityCoreTestKit
  module Client
    module USQualityCoreClientV010
      class PatientClientGroup < Inferno::TestGroup
        id :us_quality_core_client_v010_patient

        title 'Patient'

        description %(

# Background

This test group verifies that the client can access Patient data
conforming to the US Quality Core Patient.

# Testing Methodology

## Data Access Supported

Clients may not be required to support the Patient FHIR resource type. However, if they
do support it, they must support the US Quality Core Patient and the resource type's search parameters.
The tests in this group will not execute if client makes no attempt to access data for the
Patient resource type. In this case, the test will be marked as skip if support
for the resource type is required, and omitted otherwise.

## Reading
This test will check that the client performed a read of the following id:

* `us-quality-core-test-kit-patient`

## Searching
These tests will check that the client performed searches against the
Patient resource type with the following required parameters:

* _id

Inferno will also look for searches using the following optional parameters:




        )

        optional false

        run_as_group

        test from: :us_quality_core_v010_patient_client_read_test
        test from: :us_quality_core_v010_patient_id_client_search_test
      end
    end
  end
end
