require_relative '../../version'

require_relative 'patient_group'
require_relative 'adverse_event_group'
require_relative 'allergy_intolerance_group'
require_relative 'care_plan_group'
require_relative 'care_team_group'
require_relative 'claim_group'
require_relative 'condition_encounter_diagnosis_group'
require_relative 'condition_problems_health_concerns_group'
require_relative 'coverage_group'
require_relative 'devicerequest_group'
require_relative 'devicenotrequested_group'
require_relative 'diagnostic_report_note_group'
require_relative 'diagnostic_report_lab_group'
require_relative 'document_reference_group'
require_relative 'family_member_history_group'
require_relative 'goal_group'
require_relative 'imaging_study_group'
require_relative 'immunization_group'
require_relative 'immunizationnotdone_group'
require_relative 'medicationadministration_group'
require_relative 'medicationadministrationnotdone_group'
require_relative 'medicationdispense_group'
require_relative 'medicationdispensedeclined_group'
require_relative 'medicationrequest_group'
require_relative 'medicationnotrequested_group'
require_relative 'observation_clinical_result_group'
require_relative 'simple_observation_group'
require_relative 'observation_screening_assessment_group'
require_relative 'observationcancelled_group'
require_relative 'us_core_observation_pregnancyintent_group'
require_relative 'us_core_observation_pregnancystatus_group'
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
require_relative 'related_person_group'
require_relative 'servicerequest_group'
require_relative 'servicenotrequested_group'
require_relative 'task_group'
require_relative 'taskrejected_group'
require_relative 'encounter_group'
require_relative 'location_group'
require_relative 'organization_group'
require_relative 'practitioner_group'
require_relative 'practitioner_role_group'
require_relative 'provenance_group'
require_relative 'specimen_group'


module USQualityCoreTestKit
  module USCoreV050
    class USQualityCoreTestSuite < Inferno::TestSuite
      title 'US Quality Core Server v0.5.0'

      description %(
        The US Quality Core Server Test Kit tests server systems for their conformance to the [US Quality Core
        Implementation Guide](http://fhir.org/guides/onc/us-quality-core).

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
        %r{Patient.*Patient\.extension\[\d+\]\[url='http://hl7\.org/fhir/us/core/StructureDefinition/us-core-(race|ethnicity|tribal-affiliation)\|\d+\.\d+(?:\.\d+)?'\]:\s*The extension URL must not contain a version\.},
        %r{Patient.*Patient\.extension\[\d+\]\.url:\s*Value is 'http://hl7\.org/fhir/us/core/StructureDefinition/us-core-(race|ethnicity|tribal-affiliation)\|\d+\.\d+(?:\.\d+)?'\s*but is fixed to 'http://hl7\.org/fhir/us/core/StructureDefinition/us-core-(race|ethnicity|tribal-affiliation)'\s*in the profile http://hl7\.org/fhir/us/core/StructureDefinition/us-core-(race|ethnicity|tribal-affiliation)\|\d+\.\d+(?:\.\d+)?#Extension\.url},
        %r{DeviceRequest.*DeviceRequest\.modifierExtension\[\d+\]:\s*Slicing cannot be evaluated:\s*Unable to resolve profile CanonicalType\[http://hl7\.org/fhir/5\.0/StructureDefinition/extension-DeviceRequest\.doNotPerform\]}
      ].freeze


      VALIDATION_MESSAGE_FILTERS = GENERAL_MESSAGE_FILTERS + VERSION_SPECIFIC_MESSAGE_FILTERS

      def self.metadata
        @metadata ||= YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true)[:groups].map do |raw_metadata|
            Generator::GroupMetadata.new(raw_metadata)
          end
      end

      id :us_quality_core_v050

      fhir_resource_validator do
        igs 'igs/us_quality_core_v050.tgz'

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

        id :us_quality_core_v050_fhir_api

        config(
          options: {
            tag_requests: true
          }
        )

        
        group from: :us_quality_core_v050_patient
        group from: :us_quality_core_v050_adverse_event
        group from: :us_quality_core_v050_allergy_intolerance
        group from: :us_quality_core_v050_care_plan
        group from: :us_quality_core_v050_care_team
        group from: :us_quality_core_v050_claim
        group from: :us_quality_core_v050_condition_encounter_diagnosis
        group from: :us_quality_core_v050_condition_problems_health_concerns
        group from: :us_quality_core_v050_coverage
        group from: :us_quality_core_v050_devicerequest
        group from: :us_quality_core_v050_devicenotrequested
        group from: :us_quality_core_v050_diagnostic_report_note
        group from: :us_quality_core_v050_diagnostic_report_lab
        group from: :us_quality_core_v050_document_reference
        group from: :us_quality_core_v050_family_member_history
        group from: :us_quality_core_v050_goal
        group from: :us_quality_core_v050_imaging_study
        group from: :us_quality_core_v050_immunization
        group from: :us_quality_core_v050_immunizationnotdone
        group from: :us_quality_core_v050_medicationadministration
        group from: :us_quality_core_v050_medicationadministrationnotdone
        group from: :us_quality_core_v050_medicationdispense
        group from: :us_quality_core_v050_medicationdispensedeclined
        group from: :us_quality_core_v050_medicationrequest
        group from: :us_quality_core_v050_medicationnotrequested
        group from: :us_quality_core_v050_observation_clinical_result
        group from: :us_quality_core_v050_simple_observation
        group from: :us_quality_core_v050_observation_screening_assessment
        group from: :us_quality_core_v050_observationcancelled
        group from: :us_quality_core_v050_us_core_observation_pregnancyintent
        group from: :us_quality_core_v050_us_core_observation_pregnancystatus
        group from: :us_quality_core_v050_us_core_smokingstatus
        group from: :us_quality_core_v050_observation_lab
        group from: :us_quality_core_v050_us_core_observation_occupation
        group from: :us_quality_core_v050_us_core_blood_pressure
        group from: :us_quality_core_v050_us_core_bmi
        group from: :us_quality_core_v050_pediatric_bmi_for_age
        group from: :us_quality_core_v050_us_core_body_height
        group from: :us_quality_core_v050_us_core_body_temperature
        group from: :us_quality_core_v050_us_core_body_weight
        group from: :us_quality_core_v050_head_occipital_frontal_circumference_percentile
        group from: :us_quality_core_v050_us_core_heart_rate
        group from: :us_quality_core_v050_us_core_pulse_oximetry
        group from: :us_quality_core_v050_us_core_respiratory_rate
        group from: :us_quality_core_v050_pediatric_weight_for_height
        group from: :us_quality_core_v050_procedure
        group from: :us_quality_core_v050_procedurenotdone
        group from: :us_quality_core_v050_related_person
        group from: :us_quality_core_v050_servicerequest
        group from: :us_quality_core_v050_servicenotrequested
        group from: :us_quality_core_v050_task
        group from: :us_quality_core_v050_taskrejected
        group from: :us_quality_core_v050_encounter
        group from: :us_quality_core_v050_location
        group from: :us_quality_core_v050_organization
        group from: :us_quality_core_v050_practitioner
        group from: :us_quality_core_v050_practitioner_role
        group from: :us_quality_core_v050_provenance
        group from: :us_quality_core_v050_specimen
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
