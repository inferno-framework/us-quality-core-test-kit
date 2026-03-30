# frozen_string_literal: true

require_relative '../../../version'
require_relative 'tags'
require_relative 'urls'
require_relative '../../metadata_helper'
require_relative 'read_endpoint'
require_relative 'search_endpoint'
require_relative '../../test_helper'
require_relative 'wait_group'

require_relative 'patient_client_group'
require_relative 'adverse_event_client_group'
require_relative 'allergy_intolerance_client_group'
require_relative 'care_plan_client_group'
require_relative 'care_team_client_group'
require_relative 'claim_client_group'
require_relative 'condition_encounter_diagnosis_client_group'
require_relative 'condition_problems_health_concerns_client_group'
require_relative 'coverage_client_group'
require_relative 'devicerequest_client_group'
require_relative 'devicenotrequested_client_group'
require_relative 'diagnostic_report_note_client_group'
require_relative 'diagnostic_report_lab_client_group'
require_relative 'family_member_history_client_group'
require_relative 'goal_client_group'
require_relative 'immunization_client_group'
require_relative 'immunizationnotdone_client_group'
require_relative 'medicationadministration_client_group'
require_relative 'medicationadministrationnotdone_client_group'
require_relative 'medicationdispense_client_group'
require_relative 'medicationdispensedeclined_client_group'
require_relative 'medicationrequest_client_group'
require_relative 'medicationnotrequested_client_group'
require_relative 'observation_clinical_result_client_group'
require_relative 'simple_observation_client_group'
require_relative 'observation_screening_assessment_client_group'
require_relative 'observationcancelled_client_group'
require_relative 'observation_lab_client_group'
require_relative 'procedure_client_group'
require_relative 'procedurenotdone_client_group'
require_relative 'related_person_client_group'
require_relative 'servicerequest_client_group'
require_relative 'servicenotrequested_client_group'
require_relative 'task_client_group'
require_relative 'taskrejected_client_group'
require_relative 'encounter_client_group'
require_relative 'location_client_group'
require_relative 'organization_client_group'
require_relative 'practitioner_client_group'
require_relative 'practitioner_role_client_group'

module USQualityCoreTestKit
  module Client
    module USQualityCoreClientV010
      class USQualityCoreClientTestSuite < Inferno::TestSuite
        include URLs

        id :us_quality_core_client_v010

        title 'US Quality Core Client v0.1.0'

        description %(
          
The US Quality Core Test Kit Client Suite tests client systems for
conformance to the [US Quality Core Implementation Guide](http://fhir.org/guides/astp/us-quality-core).

# Scope

These tests are a DRAFT intended to allow implementers to perform
preliminary checks of client systems against the requirements stated
in the US Quality Core Implementation Guide and provide feedback on the tests.
Future versions of these tests may verify other requirements and may
change the test verification logic.

# Test Methodology

Inferno simulates a US Quality Core conformant FHIR server containing
resources for each US Quality Core profile, and provides a standard FHIR
RESTful API implementation to search and read these resources.
During execution, Inferno will wait for the client under test to
issue requests and will respond to them with the requested data.
Inferno will then evaluate the requests in aggregate to verify that
they demonstrate that the client:

* Retrieved a target instance for each profile.
* Performed searches using the required search parameters and search
  parameter combinations for the profile's resource type.

# Interpreting the Results

These tests will check for support for requesting data for every
US Quality Core profile.  The "Read & Search" group includes a sub-group for
each US Quality Core profile. Groups for profiles of resources that are
required by the US Quality Core Client CapabilityStatement are marked as
required while groups for others are optional. Each profile group
will be evaluated on every run through these tests, but feedback
will only be provided on profiles of resource types that the client
makes requests for.
- If a client makes a request for a given resource type, support for
  all profiles of that resource type will be evaluated, meaning that
  the group for each profile of that resource type will be executed,
  checking that the client read the target instance for that profile
  and perform searches with all required search parameters and
  combinations for the resource type. The executed group will pass or
  fail and include details of the issues encountered by Inferno.
- If a client makes no requests for a given resource type, support
  is not evaluated. If support for the resource type is required, the
  tests will be marked as skipped, forcing an overall failure.
  Otherwise, the tests will be marked as omitted on the assumption
  that the client does not support the optional resource type and
  profile represented by the group.

The tests will not pass unless at least one profile group passes.


        )

        links [
          {
            type: 'report_issue',
            label: 'Report Issue',
            url: 'TODO'
          },
          {
            type: 'source_code',
            label: 'Open Source',
            url: 'TODO'
          },
          {
            type: 'download',
            label: 'Download',
            url: 'TODO'
          },
          {
            label: 'Implementation Guide',
            url: 'http://fhir.org/guides/astp/us-quality-core'
          }
        ]

        route(:get, METADATA_PATH, USQualityCoreTestKit::Client::MetadataHelper.get_metadata('v010'))

        suite_endpoint :post, SEARCH_POST_ROUTE, SearchEndpoint
        suite_endpoint :get, SEARCH_ROUTE, SearchEndpoint
        suite_endpoint :get, READ_ROUTE, ReadEndpoint

        resume_test_route :get, RESUME_PASS_ROUTE do |request|
          request.query_parameters['token']
        end

        group do
          id :us_quality_core_client_read_search_group_v010

          title 'Read & Search'

          description %(
            
During these tests, the US Quality Core client system will interact with
Inferno's simulated US Quality Core Server and demonstrate its ability to
perform the FHIR interactions described in the [US Quality Core Client
CapabilityStatement](http://fhir.org/guides/astp/us-quality-core/CapabilityStatement-US Quality Core-client.html).


          )

          group from: :us_quality_core_client_access_group_v010

          group from: :us_quality_core_client_v010_patient
          group from: :us_quality_core_client_v010_adverse_event
          group from: :us_quality_core_client_v010_allergy_intolerance
          group from: :us_quality_core_client_v010_care_plan
          group from: :us_quality_core_client_v010_care_team
          group from: :us_quality_core_client_v010_claim
          group from: :us_quality_core_client_v010_condition_encounter_diagnosis
          group from: :us_quality_core_client_v010_condition_problems_health_concerns
          group from: :us_quality_core_client_v010_coverage
          group from: :us_quality_core_client_v010_devicerequest
          group from: :us_quality_core_client_v010_devicenotrequested
          group from: :us_quality_core_client_v010_diagnostic_report_note
          group from: :us_quality_core_client_v010_diagnostic_report_lab
          group from: :us_quality_core_client_v010_family_member_history
          group from: :us_quality_core_client_v010_goal
          group from: :us_quality_core_client_v010_immunization
          group from: :us_quality_core_client_v010_immunizationnotdone
          group from: :us_quality_core_client_v010_medicationadministration
          group from: :us_quality_core_client_v010_medicationadministrationnotdone
          group from: :us_quality_core_client_v010_medicationdispense
          group from: :us_quality_core_client_v010_medicationdispensedeclined
          group from: :us_quality_core_client_v010_medicationrequest
          group from: :us_quality_core_client_v010_medicationnotrequested
          group from: :us_quality_core_client_v010_observation_clinical_result
          group from: :us_quality_core_client_v010_simple_observation
          group from: :us_quality_core_client_v010_observation_screening_assessment
          group from: :us_quality_core_client_v010_observationcancelled
          group from: :us_quality_core_client_v010_observation_lab
          group from: :us_quality_core_client_v010_procedure
          group from: :us_quality_core_client_v010_procedurenotdone
          group from: :us_quality_core_client_v010_related_person
          group from: :us_quality_core_client_v010_servicerequest
          group from: :us_quality_core_client_v010_servicenotrequested
          group from: :us_quality_core_client_v010_task
          group from: :us_quality_core_client_v010_taskrejected
          group from: :us_quality_core_client_v010_encounter
          group from: :us_quality_core_client_v010_location
          group from: :us_quality_core_client_v010_organization
          group from: :us_quality_core_client_v010_practitioner
          group from: :us_quality_core_client_v010_practitioner_role

          run do
            passing_profile_group = groups.find do |group|
              next if group.id.include?('wait') || group.id.include?('auth')

              results[group.id]&.result == 'pass'
            end

            assert passing_profile_group.present?, 'At least one profile group must pass.'
          end
        end
      end
    end
  end
end
