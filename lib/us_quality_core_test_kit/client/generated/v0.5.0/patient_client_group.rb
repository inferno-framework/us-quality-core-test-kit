# frozen_string_literal: true

require_relative 'patient/patient_client_read_test'
require_relative 'patient/patient_client_search_test'

module USQualityCoreTestKit
  module Client
    module USQualityCoreClientV050
      class PatientClientGroup < Inferno::TestGroup
        id :us_quality_core_client_v050_patient

        title 'Patient'

        description %(

# Background

This test group verifies that the client can access Patient data
conforming to the US Quality Core Patient Profile.

# Testing Methodology

## Data Access Supported

Clients may not be required to support the Patient FHIR resource type. However, if they
do support it, they must support the US Quality Core Patient Profile and use a supported search to access its data.
The tests in this group will not execute if client makes no attempt to access data for the
Patient resource type. In this case, the test will be marked as skip if support
for the resource type is required, and omitted otherwise.

## Reading
This test checks that the client performed a read of any Patient resource, regardless of its ID.

## Searching
The client must demonstrate at least one of the following search parameter
combinations supported by the server for Patient:

* _id


        )

        optional false

        run_as_group

        test from: :us_quality_core_v050_patient_client_read_test
        test from: :us_quality_core_v050_patient_client_search_test
      end
    end
  end
end
