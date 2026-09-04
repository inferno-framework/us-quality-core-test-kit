require_relative '../../../must_support_test'

module USQualityCoreTestKit
  module USQualityCoreV050
    class EncounterMustSupportTest < Inferno::Test
      include USQualityCoreTestKit::MustSupportTest

      title 'All must support elements are provided in the Encounter resources returned'

      description %(
        This test will look through the Encounter resources
        found previously for the following Must Support and USCDI-flagged elements:

        * Encounter.class
        * Encounter.diagnosis.extension:diagnosisPresentOnAdmission
        * Encounter.hospitalization
        * Encounter.hospitalization.dischargeDisposition
        * Encounter.identifier
        * Encounter.identifier.system
        * Encounter.identifier.value
        * Encounter.location
        * Encounter.location.location or Encounter.serviceProvider
        * Encounter.participant
        * Encounter.participant.individual
        * Encounter.participant.period
        * Encounter.participant.type
        * Encounter.period
        * Encounter.reasonCode or Encounter.reasonReference
        * Encounter.status
        * Encounter.subject
        * Encounter.type

        For ONC USCDI+ Quality requirements, each Encounter must support the following additional elements:

        * Encounter.diagnosis
        * Encounter.priority
      )

      id :us_quality_core_v050_encounter_must_support_test

      def resource_type
        'Encounter'
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:encounter_resources] ||= {}
      end

      run do
        perform_must_support_test(all_scratch_resources)
      end
    end
  end
end
