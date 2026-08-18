require_relative '../../version'

require_relative 'patient_group'
require_relative 'adverse_event_group'
require_relative 'allergy_intolerance_group'
require_relative 'care_plan_group'
require_relative 'care_team_group'
require_relative 'communication_group'
require_relative 'communicationdone_group'
require_relative 'communicationnotdone_group'
require_relative 'condition_encounter_diagnosis_group'
require_relative 'condition_problems_health_concerns_group'
require_relative 'coverage_group'
require_relative 'device_group'
require_relative 'devicerequest_group'
require_relative 'devicerequested_group'
require_relative 'deviceprohibited_group'
require_relative 'diagnostic_report_note_group'
require_relative 'diagnostic_report_lab_group'
require_relative 'document_reference_group'
require_relative 'family_member_history_group'
require_relative 'goal_group'
require_relative 'imaging_study_group'
require_relative 'immunization_group'
require_relative 'immunizationnotdone_group'
require_relative 'immunizationdone_group'
require_relative 'medicationadministration_group'
require_relative 'medicationadministrationnotdone_group'
require_relative 'medicationadministrationdone_group'
require_relative 'medicationdispense_group'
require_relative 'medicationdispensedeclined_group'
require_relative 'medicationdispensedone_group'
require_relative 'medicationrequest_group'
require_relative 'medicationprohibited_group'
require_relative 'medicationrequested_group'
require_relative 'nutrition_order_group'
require_relative 'observation_clinical_result_group'
require_relative 'us_core_observation_adi_documentation_group'
require_relative 'us_core_treatment_intervention_preference_group'
require_relative 'simple_observation_group'
require_relative 'observation_screening_assessment_group'
require_relative 'us_core_observation_pregnancystatus_group'
require_relative 'us_core_observation_pregnancyintent_group'
require_relative 'us_core_smokingstatus_group'
require_relative 'observation_lab_group'
require_relative 'us_core_observation_occupation_group'
require_relative 'us_core_blood_pressure_group'
require_relative 'us_core_bmi_group'
require_relative 'pediatric_bmi_for_age_group'
require_relative 'us_core_body_height_group'
require_relative 'us_core_body_temperature_group'
require_relative 'us_core_body_weight_group'
require_relative 'head_occipital_frontal_circumference_percentile_group'
require_relative 'us_core_heart_rate_group'
require_relative 'us_core_pulse_oximetry_group'
require_relative 'us_core_respiratory_rate_group'
require_relative 'pediatric_weight_for_height_group'
require_relative 'procedure_group'
require_relative 'procedurenotdone_group'
require_relative 'proceduredone_group'
require_relative 'questionnaire_response_group'
require_relative 'related_person_group'
require_relative 'servicerequest_group'
require_relative 'serviceprohibited_group'
require_relative 'servicerequested_group'
require_relative 'task_group'
require_relative 'taskrejected_group'
require_relative 'taskdone_group'
require_relative 'encounter_group'
require_relative 'location_group'
require_relative 'organization_group'
require_relative 'practitioner_group'
require_relative 'practitioner_role_group'
require_relative 'provenance_group'
require_relative 'specimen_group'


module USQualityCoreTestKit
  module USCoreV100_BALLOT
    class USQualityCoreTestSuite < Inferno::TestSuite
      title 'US Quality Core Server v1.0.0-ballot'

      description %(
        The US Quality Core Server Test Kit tests server systems for their conformance to the [US Quality Core
        Implementation Guide](http://hl7.org/fhir/us/quality-core/1.0.0-202609-ballot/en).

        # Scope

        These tests are a DRAFT intended to allow implementers to perform
        preliminary checks of server systems against the requirements stated
        in the US Quality Core Implementation Guide and provide feedback on the tests.
        Future versions of these tests may verify other requirements and may
        change the test verification logic.


        # Test Methodology

        These test simulate a realistic client that is capable of retrieving
        all necessary information necessary to perform calculation measurement
        against a single patient from a US Quality Core conformant server.  HL7® FHIR®
        resources are validated with the Java validator using `tx.fhir.org` as
        the terminology server.
      )

      GENERAL_MESSAGE_FILTERS = [
        /Observation\.effective\.ofType\(Period\): .*vs-1:/, # Invalid invariant in FHIR v4.0.1
        %r{No definition could be found for URL value 'http://hl7.org/fhir/us/core/CodeSystem/us-core-tags'}, # Validator has an issue with this US Core 5 code system in US Core 6 resource
        # temporary disable these two errors. 
        # us-core-medication-adherence and http://hl7.org/fhir/us/core/StructureDefinition/us-core-interpreter-needed are defined in us-core-7 
        # but us-quality-core is based on us-core-6
        %r{No definition could be found for URL value 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-medication-adherence'}, 
        %r{No definition could be found for URL value 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-interpreter-needed'}
      ].freeze


      VERSION_SPECIFIC_MESSAGE_FILTERS = [
        %r{\bPatient\.extension},
        %r{DeviceRequest.*DeviceRequest\.modifierExtension\[\d+\]:\s*Slicing cannot be evaluated:\s*Unable to resolve profile CanonicalType\[http://hl7\.org/fhir/5\.0/StructureDefinition/extension-DeviceRequest\.doNotPerform\]}
      ].freeze


      VALIDATION_MESSAGE_FILTERS = GENERAL_MESSAGE_FILTERS + VERSION_SPECIFIC_MESSAGE_FILTERS

      def self.metadata
        @metadata ||= YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true)[:groups].map do |raw_metadata|
            Generator::GroupMetadata.new(raw_metadata)
          end
      end

      id :us_quality_core_v100_ballot

      fhir_resource_validator do
        igs 'fhir.onc.us-quality-core#1.0.0-ballot'

        message_filters = VALIDATION_MESSAGE_FILTERS

        exclude_message do |message|
          message_filters.any? { |filter| filter.match? message.message }
        end
      end

      input :url,
        title: 'FHIR Endpoint',
        description: 'URL of the FHIR endpoint'

      group do
        input :smart_auth_info,
          title: 'OAuth Credentials',
          type: :auth_info,
          optional: true

        fhir_client do
          url :url
          auth_info :smart_auth_info
        end

        title 'US Quality Core FHIR API'

        id :us_quality_core_v100_ballot_fhir_api

        config(
          options: {
            tag_requests: true
          }
        )

        
        group from: :us_quality_core_v100_ballot_patient
        group from: :us_quality_core_v100_ballot_adverse_event
        group from: :us_quality_core_v100_ballot_allergy_intolerance
        group from: :us_quality_core_v100_ballot_care_plan
        group from: :us_quality_core_v100_ballot_care_team
        group from: :us_quality_core_v100_ballot_communication
        group from: :us_quality_core_v100_ballot_communicationdone
        group from: :us_quality_core_v100_ballot_communicationnotdone
        group from: :us_quality_core_v100_ballot_condition_encounter_diagnosis
        group from: :us_quality_core_v100_ballot_condition_problems_health_concerns
        group from: :us_quality_core_v100_ballot_coverage
        group from: :us_quality_core_v100_ballot_device
        group from: :us_quality_core_v100_ballot_devicerequest
        group from: :us_quality_core_v100_ballot_devicerequested
        group from: :us_quality_core_v100_ballot_deviceprohibited
        group from: :us_quality_core_v100_ballot_diagnostic_report_note
        group from: :us_quality_core_v100_ballot_diagnostic_report_lab
        group from: :us_quality_core_v100_ballot_document_reference
        group from: :us_quality_core_v100_ballot_family_member_history
        group from: :us_quality_core_v100_ballot_goal
        group from: :us_quality_core_v100_ballot_imaging_study
        group from: :us_quality_core_v100_ballot_immunization
        group from: :us_quality_core_v100_ballot_immunizationnotdone
        group from: :us_quality_core_v100_ballot_immunizationdone
        group from: :us_quality_core_v100_ballot_medicationadministration
        group from: :us_quality_core_v100_ballot_medicationadministrationnotdone
        group from: :us_quality_core_v100_ballot_medicationadministrationdone
        group from: :us_quality_core_v100_ballot_medicationdispense
        group from: :us_quality_core_v100_ballot_medicationdispensedeclined
        group from: :us_quality_core_v100_ballot_medicationdispensedone
        group from: :us_quality_core_v100_ballot_medicationrequest
        group from: :us_quality_core_v100_ballot_medicationprohibited
        group from: :us_quality_core_v100_ballot_medicationrequested
        group from: :us_quality_core_v100_ballot_nutrition_order
        group from: :us_quality_core_v100_ballot_observation_clinical_result
        group from: :us_quality_core_v100_ballot_us_core_observation_adi_documentation
        group from: :us_quality_core_v100_ballot_us_core_treatment_intervention_preference
        group from: :us_quality_core_v100_ballot_simple_observation
        group from: :us_quality_core_v100_ballot_observation_screening_assessment
        group from: :us_quality_core_v100_ballot_us_core_observation_pregnancystatus
        group from: :us_quality_core_v100_ballot_us_core_observation_pregnancyintent
        group from: :us_quality_core_v100_ballot_us_core_smokingstatus
        group from: :us_quality_core_v100_ballot_observation_lab
        group from: :us_quality_core_v100_ballot_us_core_observation_occupation
        group from: :us_quality_core_v100_ballot_us_core_blood_pressure
        group from: :us_quality_core_v100_ballot_us_core_bmi
        group from: :us_quality_core_v100_ballot_pediatric_bmi_for_age
        group from: :us_quality_core_v100_ballot_us_core_body_height
        group from: :us_quality_core_v100_ballot_us_core_body_temperature
        group from: :us_quality_core_v100_ballot_us_core_body_weight
        group from: :us_quality_core_v100_ballot_head_occipital_frontal_circumference_percentile
        group from: :us_quality_core_v100_ballot_us_core_heart_rate
        group from: :us_quality_core_v100_ballot_us_core_pulse_oximetry
        group from: :us_quality_core_v100_ballot_us_core_respiratory_rate
        group from: :us_quality_core_v100_ballot_pediatric_weight_for_height
        group from: :us_quality_core_v100_ballot_procedure
        group from: :us_quality_core_v100_ballot_procedurenotdone
        group from: :us_quality_core_v100_ballot_proceduredone
        group from: :us_quality_core_v100_ballot_questionnaire_response
        group from: :us_quality_core_v100_ballot_related_person
        group from: :us_quality_core_v100_ballot_servicerequest
        group from: :us_quality_core_v100_ballot_serviceprohibited
        group from: :us_quality_core_v100_ballot_servicerequested
        group from: :us_quality_core_v100_ballot_task
        group from: :us_quality_core_v100_ballot_taskrejected
        group from: :us_quality_core_v100_ballot_taskdone
        group from: :us_quality_core_v100_ballot_encounter
        group from: :us_quality_core_v100_ballot_location
        group from: :us_quality_core_v100_ballot_organization
        group from: :us_quality_core_v100_ballot_practitioner
        group from: :us_quality_core_v100_ballot_practitioner_role
        group from: :us_quality_core_v100_ballot_provenance
        group from: :us_quality_core_v100_ballot_specimen
      end

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
        }
      ]
    end
  end
end
