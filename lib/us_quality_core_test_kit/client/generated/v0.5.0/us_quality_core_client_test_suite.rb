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
require_relative 'condition_encounter_diagnosis_client_group'
require_relative 'condition_problems_health_concerns_client_group'
require_relative 'coverage_client_group'
require_relative 'devicerequest_client_group'
require_relative 'devicenotrequested_client_group'
require_relative 'diagnostic_report_note_client_group'
require_relative 'diagnostic_report_lab_client_group'
require_relative 'document_reference_client_group'
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
require_relative 'us_core_observation_pregnancyintent_client_group'
require_relative 'us_core_observation_pregnancystatus_client_group'
require_relative 'us_core_smokingstatus_client_group'
require_relative 'observation_lab_client_group'
require_relative 'us_core_observation_occupation_client_group'
require_relative 'us_core_blood_pressure_client_group'
require_relative 'us_core_bmi_client_group'
require_relative 'pediatric_bmi_for_age_client_group'
require_relative 'us_core_body_height_client_group'
require_relative 'us_core_body_temperature_client_group'
require_relative 'us_core_body_weight_client_group'
require_relative 'head_occipital_frontal_circumference_percentile_client_group'
require_relative 'us_core_heart_rate_client_group'
require_relative 'us_core_pulse_oximetry_client_group'
require_relative 'us_core_respiratory_rate_client_group'
require_relative 'pediatric_weight_for_height_client_group'
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
require_relative 'provenance_client_group'
require_relative 'specimen_client_group'

module USQualityCoreTestKit
  module Client
    module USQualityCoreClientV050
      class USQualityCoreClientTestSuite < Inferno::TestSuite
        include URLs

        id :us_quality_core_client_v050

        title 'US Quality Core Client v0.5.0'

        description %(
          
The US Quality Core Test Kit Client Suite tests client systems for
conformance to the [US Quality Core Implementation Guide](http://fhir.org/guides/onc/us-quality-core).

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
            url: 'https://github.com/inferno-framework/us-quality-core-test-kit/issues'
          },
          {
            type: 'source_code',
            label: 'Open Source',
            url: 'https://github.com/inferno-framework/us-quality-core-test-kit'
          },
          {
            type: 'download',
            label: 'Download',
            url: 'https://github.com/inferno-framework/us-quality-core-test-kit/releases'
          },
          {
            label: 'Implementation Guide',
            url: 'http://fhir.org/guides/onc/us-quality-core'
          }
        ]

        route(:get, METADATA_PATH, USQualityCoreTestKit::Client::MetadataHelper.get_metadata(
          'v050',
          File.join(__dir__, 'capability_statement_v050.json.erb')
        ))

        suite_endpoint :post, SEARCH_POST_ROUTE, SearchEndpoint
        suite_endpoint :get, SEARCH_ROUTE, SearchEndpoint
        suite_endpoint :get, READ_ROUTE, ReadEndpoint

        resume_test_route :get, RESUME_PASS_ROUTE do |request|
          request.query_parameters['token']
        end

        group do
          id :us_quality_core_client_read_search_group_v050

          title 'Read & Search'

          description %(
            
During these tests, the US Quality Core client system will interact with
Inferno's simulated US Quality Core Server and demonstrate its ability to
perform the FHIR interactions described in the [US Quality Core Client
CapabilityStatement](http://fhir.org/guides/onc/us-quality-core/CapabilityStatement-us-quality-core-server.html).


          )

          group from: :us_quality_core_client_access_group_v050

          group from: :us_quality_core_client_v050_patient
          group from: :us_quality_core_client_v050_adverse_event
          group from: :us_quality_core_client_v050_allergy_intolerance
          group from: :us_quality_core_client_v050_care_plan
          group from: :us_quality_core_client_v050_care_team
          group from: :us_quality_core_client_v050_condition_encounter_diagnosis
          group from: :us_quality_core_client_v050_condition_problems_health_concerns
          group from: :us_quality_core_client_v050_coverage
          group from: :us_quality_core_client_v050_devicerequest
          group from: :us_quality_core_client_v050_devicenotrequested
          group from: :us_quality_core_client_v050_diagnostic_report_note
          group from: :us_quality_core_client_v050_diagnostic_report_lab
          group from: :us_quality_core_client_v050_document_reference
          group from: :us_quality_core_client_v050_family_member_history
          group from: :us_quality_core_client_v050_goal
          group from: :us_quality_core_client_v050_immunization
          group from: :us_quality_core_client_v050_immunizationnotdone
          group from: :us_quality_core_client_v050_medicationadministration
          group from: :us_quality_core_client_v050_medicationadministrationnotdone
          group from: :us_quality_core_client_v050_medicationdispense
          group from: :us_quality_core_client_v050_medicationdispensedeclined
          group from: :us_quality_core_client_v050_medicationrequest
          group from: :us_quality_core_client_v050_medicationnotrequested
          group from: :us_quality_core_client_v050_observation_clinical_result
          group from: :us_quality_core_client_v050_simple_observation
          group from: :us_quality_core_client_v050_observation_screening_assessment
          group from: :us_quality_core_client_v050_observationcancelled
          group from: :us_quality_core_client_v050_us_core_observation_pregnancyintent
          group from: :us_quality_core_client_v050_us_core_observation_pregnancystatus
          group from: :us_quality_core_client_v050_us_core_smokingstatus
          group from: :us_quality_core_client_v050_observation_lab
          group from: :us_quality_core_client_v050_us_core_observation_occupation
          group from: :us_quality_core_client_v050_us_core_blood_pressure
          group from: :us_quality_core_client_v050_us_core_bmi
          group from: :us_quality_core_client_v050_pediatric_bmi_for_age
          group from: :us_quality_core_client_v050_us_core_body_height
          group from: :us_quality_core_client_v050_us_core_body_temperature
          group from: :us_quality_core_client_v050_us_core_body_weight
          group from: :us_quality_core_client_v050_head_occipital_frontal_circumference_percentile
          group from: :us_quality_core_client_v050_us_core_heart_rate
          group from: :us_quality_core_client_v050_us_core_pulse_oximetry
          group from: :us_quality_core_client_v050_us_core_respiratory_rate
          group from: :us_quality_core_client_v050_pediatric_weight_for_height
          group from: :us_quality_core_client_v050_procedure
          group from: :us_quality_core_client_v050_procedurenotdone
          group from: :us_quality_core_client_v050_related_person
          group from: :us_quality_core_client_v050_servicerequest
          group from: :us_quality_core_client_v050_servicenotrequested
          group from: :us_quality_core_client_v050_task
          group from: :us_quality_core_client_v050_taskrejected
          group from: :us_quality_core_client_v050_encounter
          group from: :us_quality_core_client_v050_location
          group from: :us_quality_core_client_v050_organization
          group from: :us_quality_core_client_v050_practitioner
          group from: :us_quality_core_client_v050_practitioner_role
          group from: :us_quality_core_client_v050_provenance
          group from: :us_quality_core_client_v050_specimen

          run do
            profile_groups = groups.reject do |group|
              group.id == 'us_quality_core_client_access_group_v050' || group.id.end_with?('-us_quality_core_client_access_group_v050')
            end

            passing_profile_group = profile_groups.any? do |group|
              results[group.id]&.result == 'pass'
            end

            assert passing_profile_group, 'At least one profile group must pass.'
          end
        end
      end
    end
  end
end
