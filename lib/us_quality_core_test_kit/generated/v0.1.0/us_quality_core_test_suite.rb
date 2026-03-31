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
require_relative 'family_member_history_group'
require_relative 'goal_group'
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
require_relative 'observation_lab_group'
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


module USQualityCoreTestKit
  module USCoreV010
    class USQualityCoreTestSuite < Inferno::TestSuite
      title 'US Quality Core Server v0.1.0'

      description %(
        The US Quality Core Server Test Kit tests server systems for their conformance to the [US Quality Core
        Implementation Guide](http://fhir.org/guides/astp/us-quality-core).

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
        %r{No definition could be found for URL value 'http://hl7.org/fhir/us/core/CodeSystem/us-core-tags'}, # Validator has an issue with this US Core 5 code system in US Core 6 resource
        # temporary disable these two errors. 
        # us-core-medication-adherence and http://hl7.org/fhir/us/core/StructureDefinition/us-core-interpreter-needed are defined in us-core-7 
        # but us-quality-core is based on us-core-6
        %r{No definition could be found for URL value 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-medication-adherence'}, 
        %r{No definition could be found for URL value 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-interpreter-needed'}
      ].freeze


      VERSION_SPECIFIC_MESSAGE_FILTERS = [
        %r{DeviceRequest.*DeviceRequest\.modifierExtension\[\d+\]:\s*Slicing cannot be evaluated:\s*Unable to resolve profile CanonicalType\[http://hl7\.org/fhir/5\.0/StructureDefinition/extension-DeviceRequest\.doNotPerform\]}
      ].freeze


      VALIDATION_MESSAGE_FILTERS = GENERAL_MESSAGE_FILTERS + VERSION_SPECIFIC_MESSAGE_FILTERS

      def self.metadata
        @metadata ||= YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true)[:groups].map do |raw_metadata|
            Generator::GroupMetadata.new(raw_metadata)
          end
      end

      id :us_quality_core_v010

      fhir_resource_validator do
        igs 'igs/us_quality_core_v010.tgz'

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

        id :us_quality_core_v010_fhir_api

        config(
          options: {
            tag_requests: true
          }
        )

        
        group from: :us_quality_core_v010_patient
        group from: :us_quality_core_v010_adverse_event
        group from: :us_quality_core_v010_allergy_intolerance
        group from: :us_quality_core_v010_care_plan
        group from: :us_quality_core_v010_care_team
        group from: :us_quality_core_v010_claim
        group from: :us_quality_core_v010_condition_encounter_diagnosis
        group from: :us_quality_core_v010_condition_problems_health_concerns
        group from: :us_quality_core_v010_coverage
        group from: :us_quality_core_v010_devicerequest
        group from: :us_quality_core_v010_devicenotrequested
        group from: :us_quality_core_v010_diagnostic_report_note
        group from: :us_quality_core_v010_diagnostic_report_lab
        group from: :us_quality_core_v010_family_member_history
        group from: :us_quality_core_v010_goal
        group from: :us_quality_core_v010_immunization
        group from: :us_quality_core_v010_immunizationnotdone
        group from: :us_quality_core_v010_medicationadministration
        group from: :us_quality_core_v010_medicationadministrationnotdone
        group from: :us_quality_core_v010_medicationdispense
        group from: :us_quality_core_v010_medicationdispensedeclined
        group from: :us_quality_core_v010_medicationrequest
        group from: :us_quality_core_v010_medicationnotrequested
        group from: :us_quality_core_v010_observation_clinical_result
        group from: :us_quality_core_v010_simple_observation
        group from: :us_quality_core_v010_observation_screening_assessment
        group from: :us_quality_core_v010_observationcancelled
        group from: :us_quality_core_v010_observation_lab
        group from: :us_quality_core_v010_procedure
        group from: :us_quality_core_v010_procedurenotdone
        group from: :us_quality_core_v010_related_person
        group from: :us_quality_core_v010_servicerequest
        group from: :us_quality_core_v010_servicenotrequested
        group from: :us_quality_core_v010_task
        group from: :us_quality_core_v010_taskrejected
        group from: :us_quality_core_v010_encounter
        group from: :us_quality_core_v010_location
        group from: :us_quality_core_v010_organization
        group from: :us_quality_core_v010_practitioner
        group from: :us_quality_core_v010_practitioner_role
      end

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
        }
      ]
    end
  end
end
