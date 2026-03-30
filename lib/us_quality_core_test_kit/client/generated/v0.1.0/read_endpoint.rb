# frozen_string_literal: true

require_relative '../../server_proxy'
require_relative 'tags'
require_relative 'urls'

module USQualityCoreTestKit
  module Client
    module USQualityCoreClientV010
      class ReadEndpoint < Inferno::DSL::SuiteEndpoint
        include ServerProxy
        include URLs

        def test_run_identifier
          request.headers['authorization']&.delete_prefix('Bearer ')
        end

        def make_response
          build_proxied_read_response
        end

        def tags
          [READ_REQUEST_TAG, resource_to_tag(resource_type)]
        end

        def resource_to_tag(resource)
          case resource
            when 'Patient'
              READ_PATIENT_TAG
            when 'AdverseEvent'
              READ_ADVERSE_EVENT_TAG
            when 'AllergyIntolerance'
              READ_ALLERGY_INTOLERANCE_TAG
            when 'CarePlan'
              READ_CARE_PLAN_TAG
            when 'CareTeam'
              READ_CARE_TEAM_TAG
            when 'Claim'
              READ_CLAIM_TAG
            when 'Condition'
              READ_CONDITION_TAG
            when 'Coverage'
              READ_COVERAGE_TAG
            when 'DeviceRequest'
              READ_DEVICE_REQUEST_TAG
            when 'DiagnosticReport'
              READ_DIAGNOSTIC_REPORT_TAG
            when 'FamilyMemberHistory'
              READ_FAMILY_MEMBER_HISTORY_TAG
            when 'Goal'
              READ_GOAL_TAG
            when 'Immunization'
              READ_IMMUNIZATION_TAG
            when 'MedicationAdministration'
              READ_MEDICATION_ADMINISTRATION_TAG
            when 'MedicationDispense'
              READ_MEDICATION_DISPENSE_TAG
            when 'MedicationRequest'
              READ_MEDICATION_REQUEST_TAG
            when 'Observation'
              READ_OBSERVATION_TAG
            when 'Procedure'
              READ_PROCEDURE_TAG
            when 'RelatedPerson'
              READ_RELATED_PERSON_TAG
            when 'ServiceRequest'
              READ_SERVICE_REQUEST_TAG
            when 'Task'
              READ_TASK_TAG
            when 'Encounter'
              READ_ENCOUNTER_TAG
            when 'Location'
              READ_LOCATION_TAG
            when 'Organization'
              READ_ORGANIZATION_TAG
            when 'Practitioner'
              READ_PRACTITIONER_TAG
            when 'PractitionerRole'
              READ_PRACTITIONER_ROLE_TAG
          end
        end

        def resource_type
          request.params[:resource_type]
        end

        def suite_id
          USQualityCoreClientTestSuite.id
        end
      end
    end
  end
end
