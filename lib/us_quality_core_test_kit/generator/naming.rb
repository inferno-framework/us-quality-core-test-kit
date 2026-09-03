# frozen_string_literal: true

module USQualityCoreTestKit
  class Generator
    module Naming
      # From US Quality Core 1.0
      ADVERSE_EVENT = 'http://hl7.org/fhir/us/quality-core/StructureDefinition/us-quality-core-adverseevent'
      ALLERGY_INTOLERANCE = 'http://hl7.org/fhir/us/quality-core/StructureDefinition/us-quality-core-allergyintolerance'
      BODY_STRUCTURE = 'http://hl7.org/fhir/us/quality-core/StructureDefinition/us-quality-core-bodystructure'
      CARE_PLAN = 'http://hl7.org/fhir/us/quality-core/StructureDefinition/us-quality-core-careplan'
      CARE_TEAM = 'http://hl7.org/fhir/us/quality-core/StructureDefinition/us-quality-core-careteam'
      CLAIM = 'http://hl7.org/fhir/us/quality-core/StructureDefinition/us-quality-core-claim'
      CLAIM_RESPONSE = 'http://hl7.org/fhir/us/quality-core/StructureDefinition/us-quality-core-claimresponse'
      COMMUNICATION = 'http://hl7.org/fhir/us/quality-core/StructureDefinition/us-quality-core-communication'
      COMMUNICATION_DONE = 'http://hl7.org/fhir/us/quality-core/StructureDefinition/us-quality-core-communicationdone'
      COMMUNICATION_NOT_DONE = 'http://hl7.org/fhir/us/quality-core/StructureDefinition/us-quality-core-communicationnotdone'
      COMMUNICATION_REQUEST = 'http://hl7.org/fhir/us/quality-core/StructureDefinition/us-quality-core-communicationrequest'
      CONDITION_ENCOUNTER_DIAGNOSIS = 'http://hl7.org/fhir/us/quality-core/StructureDefinition/us-quality-core-condition-encounter-diagnosis'
      CONDITION_PROBLEMS_HEALTH_CONCERNS = 'http://hl7.org/fhir/us/quality-core/StructureDefinition/us-quality-core-condition-problems-health-concerns'
      COVERAGE = 'http://hl7.org/fhir/us/quality-core/StructureDefinition/us-quality-core-coverage'
      DEVICE = 'http://hl7.org/fhir/us/quality-core/StructureDefinition/us-quality-core-device'
      DEVICE_REQUEST = 'http://hl7.org/fhir/us/quality-core/StructureDefinition/us-quality-core-devicerequest'
      DEVICE_REQUESTED = 'http://hl7.org/fhir/us/quality-core/StructureDefinition/us-quality-core-devicerequested'
      DEVICE_PROHIBITED = 'http://hl7.org/fhir/us/quality-core/StructureDefinition/us-quality-core-deviceprohibited'
      DEVICE_USE_STATEMENT = 'http://hl7.org/fhir/us/quality-core/StructureDefinition/us-quality-core-deviceusestatement'
      DIAGNOSTIC_REPORT_LAB = 'http://hl7.org/fhir/us/quality-core/StructureDefinition/us-quality-core-diagnosticreport-lab'
      DIAGNOSTIC_REPORT_NOTE = 'http://hl7.org/fhir/us/quality-core/StructureDefinition/us-quality-core-diagnosticreport-note'
      DOCUMENT_REFERENCE = "http://hl7.org/fhir/us/core/StructureDefinition/us-core-documentreference"
      ADI_DOCUMENT_REFERENCE = "http://hl7.org/fhir/us/core/StructureDefinition/us-core-adi-documentreference"
      GOAL = 'http://hl7.org/fhir/us/quality-core/StructureDefinition/us-quality-core-goal'
      IMAGING_STUDY = 'http://hl7.org/fhir/us/quality-core/StructureDefinition/us-quality-core-imagingstudy'
      IMMUNIZATION = 'http://hl7.org/fhir/us/quality-core/StructureDefinition/us-quality-core-immunization'
      IMMUNIZATION_DONE = 'http://hl7.org/fhir/us/quality-core/StructureDefinition/us-quality-core-immunizationdone'
      IMMUNIZATION_NOT_DONE = 'http://hl7.org/fhir/us/quality-core/StructureDefinition/us-quality-core-immunizationnotdone'
      IMMUNIZATION_EVALUATION = 'http://hl7.org/fhir/us/quality-core/StructureDefinition/us-quality-core-immunizationevaluation'
      IMMUNIZATION_RECOMMENDATION = 'http://hl7.org/fhir/us/quality-core/StructureDefinition/us-quality-core-immunizationrecommendation'
      LOCATION = 'http://hl7.org/fhir/us/quality-core/StructureDefinition/us-quality-core-location'
      MEDICATION = 'http://hl7.org/fhir/us/quality-core/StructureDefinition/us-quality-core-medication'
      MEDICATION_ADMINISTRATION = 'http://hl7.org/fhir/us/quality-core/StructureDefinition/us-quality-core-medicationadministration'
      MEDICATION_ADMINISTRATION_DONE = 'http://hl7.org/fhir/us/quality-core/StructureDefinition/us-quality-core-medicationadministrationdone'
      MEDICATION_ADMINISTRATION_NOT_DONE = 'http://hl7.org/fhir/us/quality-core/StructureDefinition/us-quality-core-medicationadministrationnotdone'
      MEDICATION_DISPENSE = 'http://hl7.org/fhir/us/quality-core/StructureDefinition/us-quality-core-medicationdispense'
      MEDICATION_DISPENSE_DONE = 'http://hl7.org/fhir/us/quality-core/StructureDefinition/us-quality-core-medicationdispensedone'
      MEDICATION_DISPENSE_DECLINED = 'http://hl7.org/fhir/us/quality-core/StructureDefinition/us-quality-core-medicationdispensedeclined'
      MEDICATION_REQUEST = 'http://hl7.org/fhir/us/quality-core/StructureDefinition/us-quality-core-medicationrequest'    
      MEDICATION_REQUEST_REQUESTED = 'http://hl7.org/fhir/us/quality-core/StructureDefinition/us-quality-core-medicationrequested'
      MEDICATION_REQUEST_PROHIBITED = 'http://hl7.org/fhir/us/quality-core/StructureDefinition/us-quality-core-medicationprohibited'
      MEDICATION_STATEMENT = 'http://hl7.org/fhir/us/quality-core/StructureDefinition/us-quality-core-medicationstatement'
      NUTRITION_ORDER = 'http://hl7.org/fhir/us/quality-core/StructureDefinition/us-quality-core-nutritionorder'
      SIMPLE_OBSERVATION = 'http://hl7.org/fhir/us/quality-core/StructureDefinition/us-quality-core-simple-observation'
      NON_PATIENT_OBSERVATION = 'http://hl7.org/fhir/us/quality-core/StructureDefinition/us-quality-core-nonpatient-observation'
      LABORATORY_RESULT_OBSERVATION = 'http://hl7.org/fhir/us/quality-core/StructureDefinition/us-quality-core-observation-lab'
      OBSERVATION_CLINICAL_RESULT = 'http://hl7.org/fhir/us/quality-core/StructureDefinition/us-quality-core-observation-clinical-result'
      OBSERVATION_SCREENING_ASSESSMENT = 'http://hl7.org/fhir/us/quality-core/StructureDefinition/us-quality-core-observation-screening-assessment'
      OBSERVATION_CANCELLED = 'http://hl7.org/fhir/us/quality-core/StructureDefinition/us-quality-core-observationcancelled'
      ORGANIZATION = 'http://hl7.org/fhir/us/quality-core/StructureDefinition/us-quality-core-organization'
      PATIENT = 'http://hl7.org/fhir/us/quality-core/StructureDefinition/us-quality-core-patient'
      PRACTITIONER = 'http://hl7.org/fhir/us/quality-core/StructureDefinition/us-quality-core-practitioner'
      PRACTITIONER_ROLE = 'http://hl7.org/fhir/us/quality-core/StructureDefinition/us-quality-core-practitionerrole'
      PROCEDURE = 'http://hl7.org/fhir/us/quality-core/StructureDefinition/us-quality-core-procedure'
      PROCEDURE_DONE = 'http://hl7.org/fhir/us/quality-core/StructureDefinition/us-quality-core-proceduredone'
      PROCEDURE_NOT_DONE = 'http://hl7.org/fhir/us/quality-core/StructureDefinition/us-quality-core-procedurenotdone'
      QUESTIONNAIRE_RESPONSE = 'http://hl7.org/fhir/us/quality-core/StructureDefinition/us-quality-core-questionnaireresponse'
      RELATED_PERSON = 'http://hl7.org/fhir/us/quality-core/StructureDefinition/us-quality-core-relatedperson'
      SERVICE_REQUEST = 'http://hl7.org/fhir/us/quality-core/StructureDefinition/us-quality-core-servicerequest'
      SERVICE_REQUESTED = 'http://hl7.org/fhir/us/quality-core/StructureDefinition/us-quality-core-servicerequested'
      SERVICE_PROHIBITED = 'http://hl7.org/fhir/us/quality-core/StructureDefinition/us-quality-core-serviceprohibited'
      SUBSTANCE = 'http://hl7.org/fhir/us/quality-core/StructureDefinition/us-quality-core-substance'
      TASK = 'http://hl7.org/fhir/us/quality-core/StructureDefinition/us-quality-core-task'
      TASK_DONE = 'http://hl7.org/fhir/us/quality-core/StructureDefinition/us-quality-core-taskdone'
      TASK_REJECTED = 'http://hl7.org/fhir/us/quality-core/StructureDefinition/us-quality-core-taskrejected'

      # From US Quality Core v0.5.0
      DEVICE_REQUEST_V050 = 'http://fhir.org/guides/onc/us-quality-core/StructureDefinition/us-quality-core-devicerequest'
      DEVICE_NOT_REQUESTED = 'http://fhir.org/guides/onc/us-quality-core/StructureDefinition/us-quality-core-devicenotrequested'
      MEDICATION_REQUEST_V050 = 'http://fhir.org/guides/onc/us-quality-core/StructureDefinition/us-quality-core-medicationrequest'
      MEDICATION_REQUEST_NOT_REQUESTED = 'http://fhir.org/guides/onc/us-quality-core/StructureDefinition/us-quality-core-medicationnotrequested'
      SERVICE_REQUEST_V050 = 'http://fhir.org/guides/onc/us-quality-core/StructureDefinition/us-quality-core-servicerequest'
      SERVICE_NOT_REQUESTED = 'http://fhir.org/guides/onc/us-quality-core/StructureDefinition/us-quality-core-servicenotrequested'

      # From US Core directly
      IMPLANTABLE_DEVICE = 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-implantable-device'
      VITAL_SIGNS = 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-vital-signs'
      BLOOD_PRESSURE = 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-blood-pressure'
      BMI = 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-bmi'
      BODY_HEIGHT = 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-body-height'
      BODY_TEMPERATURE = 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-body-temperature'
      BODY_WEIGHT = 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-body-weight'
      HEAD_CIRCUMFERENCE = 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-head-circumference'
      HEART_RATE = 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-heart-rate'
      PEDIATRIC_BMI = 'http://hl7.org/fhir/us/core/StructureDefinition/pediatric-bmi-for-age'
      PEDIATRIC_HEAD_CIRCUMFERENCE_PERCENTILE = 'http://hl7.org/fhir/us/core/StructureDefinition/head-occipital-frontal-circumference-percentile'
      PEDIATRIC_WEIGHT_FOR_HEIGHT = 'http://hl7.org/fhir/us/core/StructureDefinition/pediatric-weight-for-height'
      PULSE_OXIMETRY = 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-pulse-oximetry'
      RESPIRATORY_RATE = 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-respiratory-rate'
      SMOKING_STATUS = 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-smokingstatus'
      OBSERVATION_OCCUPATION = 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-observation-occupation'
      OBSERVATION_SEXUAL_ORIENTATION = 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-observation-sexual-orientation'
      OBSERVATION_PREGNANCY_INTENT = 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-observation-pregnancyintent'
      OBSERVATION_PREGNANCY_STATUS = 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-observation-pregnancystatus'
      AVERAGE_BLOOD_PRESSURE = 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-average-blood-pressure'
      CARE_EXPERIENCE_PREFERENCE = 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-care-experience-preference'
      TREATMENT_INTERVENTION_PREFERENCE = 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-treatment-intervention-preference'
      SPECIMEN = 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-specimen'

      IG_LINKS = {
        'v0.5.0' => 'http://fhir.org/guides/onc/us-quality-core',
        'v1.0.0-ballot' => 'http://hl7.org/fhir/us/quality-core/1.0.0-202609-ballot/en'
      }.freeze

      INSTANCE_ID_OVERRIDES = {
        'head_occipital_frontal_circumference_percentile' =>
          'usqualitycore-head-circumference-percentile'
      }.freeze

      class << self
        def resources_with_multiple_profiles
          %w[Communication Condition DeviceRequest DiagnosticReport DocumentReference Immunization MedicationAdministration
             MedicationDispense MedicationRequest Observation Procedure ServiceRequest Task]
        end

        def resource_has_multiple_profiles?(resource)
          resources_with_multiple_profiles.include? resource
        end

        def snake_case_for_profile(group_metadata)
          resource = group_metadata.resource
          return resource.underscore unless resource_has_multiple_profiles?(resource)

          return 'head_circumference_percentile' if group_metadata.profile_url == HEAD_CIRCUMFERENCE

          group_metadata.name
                        .delete_prefix('us_quality_core_')
                        .gsub('diagnosticreport', 'diagnostic_report')
                        .underscore
        end

        def upper_camel_case_for_profile(group_metadata)
          snake_case_for_profile(group_metadata).camelize
        end

        def ig_link(version)
          IG_LINKS[version] || 'http://hl7.org/fhir/us/quality-core'
        end

        def instance_id_for_profile(profile)
          return INSTANCE_ID_OVERRIDES.fetch(profile) if INSTANCE_ID_OVERRIDES.key?(profile)

          tag = profile.gsub('us-quality-core-', '').underscore.dasherize

          id = "usqualitycore-#{tag}"
          return id if id.end_with?('notdone')

          id.delete_suffix('done')
        end
      end
    end
  end
end
