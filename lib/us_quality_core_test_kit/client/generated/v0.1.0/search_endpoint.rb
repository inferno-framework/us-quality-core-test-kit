# frozen_string_literal: true

require_relative '../../server_proxy'
require_relative 'tags'
require_relative 'urls'

module USQualityCoreTestKit
  module Client
    module USQualityCoreClientV010
      class SearchEndpoint < Inferno::DSL::SuiteEndpoint
        include ServerProxy
        include URLs

        def test_run_identifier
          request.headers['authorization']&.delete_prefix('Bearer ')
        end

        def make_response
          build_proxied_search_response
        end

        def tags
          [SEARCH_REQUEST_TAG, resource_to_tag(resource_type)]
        end

        def resource_to_tag(resource)
          case resource
            when 'Patient'
              SEARCH_PATIENT_TAG
            when 'AdverseEvent'
              SEARCH_ADVERSE_EVENT_TAG
            when 'AllergyIntolerance'
              SEARCH_ALLERGY_INTOLERANCE_TAG
            when 'CarePlan'
              SEARCH_CARE_PLAN_TAG
            when 'CareTeam'
              SEARCH_CARE_TEAM_TAG
            when 'Claim'
              SEARCH_CLAIM_TAG
            when 'Condition'
              SEARCH_CONDITION_TAG
            when 'Coverage'
              SEARCH_COVERAGE_TAG
            when 'DeviceRequest'
              SEARCH_DEVICE_REQUEST_TAG
            when 'DiagnosticReport'
              SEARCH_DIAGNOSTIC_REPORT_TAG
            when 'FamilyMemberHistory'
              SEARCH_FAMILY_MEMBER_HISTORY_TAG
            when 'Goal'
              SEARCH_GOAL_TAG
            when 'Immunization'
              SEARCH_IMMUNIZATION_TAG
            when 'MedicationAdministration'
              SEARCH_MEDICATION_ADMINISTRATION_TAG
            when 'MedicationDispense'
              SEARCH_MEDICATION_DISPENSE_TAG
            when 'MedicationRequest'
              SEARCH_MEDICATION_REQUEST_TAG
            when 'Observation'
              SEARCH_OBSERVATION_TAG
            when 'Procedure'
              SEARCH_PROCEDURE_TAG
            when 'RelatedPerson'
              SEARCH_RELATED_PERSON_TAG
            when 'ServiceRequest'
              SEARCH_SERVICE_REQUEST_TAG
            when 'Task'
              SEARCH_TASK_TAG
            when 'Encounter'
              SEARCH_ENCOUNTER_TAG
            when 'Location'
              SEARCH_LOCATION_TAG
            when 'Organization'
              SEARCH_ORGANIZATION_TAG
            when 'Practitioner'
              SEARCH_PRACTITIONER_TAG
            when 'PractitionerRole'
              SEARCH_PRACTITIONER_ROLE_TAG
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
