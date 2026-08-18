# frozen_string_literal: true

require_relative 'communicationdone/communicationdone_client_read_test'
require_relative 'communicationdone/communicationdone_subject_client_search_test'
require_relative 'communicationdone/communicationdone_subject_topic_client_search_test'
require_relative 'communicationdone/communicationdone_subject_status_client_search_test'

module USQualityCoreTestKit
  module Client
    module USQualityCoreClientV100_BALLOT
      class CommunicationdoneClientGroup < Inferno::TestGroup
        id :us_quality_core_client_v100_ballot_communicationdone

        title 'CommunicationDone'

        description %(

# Background

This test group verifies that the client can access Communication data
conforming to the US Quality Core CommunicationDone Profile.

# Testing Methodology

## Data Access Supported

Clients may not be required to support the Communication FHIR resource type. However, if they
do support it, they must support the US Quality Core CommunicationDone Profile and the resource type's search parameters.
The tests in this group will not execute if client makes no attempt to access data for the
Communication resource type. In this case, the test will be marked as skip if support
for the resource type is required, and omitted otherwise.

## Reading
This test will check that the client performed a read of the following id:

* `usqualitycore-communicationdone`

## Searching
These tests will check that the client performed searches against the
Communication resource type with the following required parameters:

* subject
* subject + topic
* subject + status

Inferno will also look for searches using the following optional parameters:




        )

        optional false

        run_as_group

        test from: :us_quality_core_v100_ballot_communicationdone_client_read_test
        test from: :us_quality_core_v100_ballot_communicationdone_subject_client_search_test
        test from: :us_quality_core_v100_ballot_communicationdone_subject_topic_client_search_test
        test from: :us_quality_core_v100_ballot_communicationdone_subject_status_client_search_test
      end
    end
  end
end
