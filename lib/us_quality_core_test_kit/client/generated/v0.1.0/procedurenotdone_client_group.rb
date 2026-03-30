# frozen_string_literal: true

require_relative 'procedurenotdone/procedurenotdone_client_read_test'
require_relative 'procedurenotdone/procedurenotdone_patient_status_client_search_test'
require_relative 'procedurenotdone/procedurenotdone_patient_client_search_test'
require_relative 'procedurenotdone/procedurenotdone_patient_date_client_search_test'

module USQualityCoreTestKit
  module Client
    module USQualityCoreClientV010
      class ProcedurenotdoneClientGroup < Inferno::TestGroup
        id :us_quality_core_client_v010_procedurenotdone

        title 'Procedure Not Done'

        description %(

# Background

This test group verifies that the client can access Procedure data
conforming to the US Quality Core Procedure Not Done.

# Testing Methodology

## Data Access Supported

Clients may not be required to support the Procedure FHIR resource type. However, if they
do support it, they must support the US Quality Core Procedure Not Done and the resource type's search parameters.
The tests in this group will not execute if client makes no attempt to access data for the
Procedure resource type. In this case, the test will be marked as skip if support
for the resource type is required, and omitted otherwise.

## Reading
This test will check that the client performed a read of the following id:

* `us-quality-core-test-kit-procedurenotdone`

## Searching
These tests will check that the client performed searches against the
Procedure resource type with the following required parameters:

* patient + status
* patient
* patient + date

Inferno will also look for searches using the following optional parameters:




        )

        optional false

        run_as_group

        test from: :us_quality_core_v010_procedurenotdone_client_read_test
        test from: :us_quality_core_v010_procedurenotdone_patient_status_client_search_test
        test from: :us_quality_core_v010_procedurenotdone_patient_client_search_test
        test from: :us_quality_core_v010_procedurenotdone_patient_date_client_search_test
      end
    end
  end
end
