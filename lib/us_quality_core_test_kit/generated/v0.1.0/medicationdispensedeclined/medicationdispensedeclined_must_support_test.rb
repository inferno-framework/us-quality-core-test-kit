require_relative '../../../must_support_test'

module USQualityCoreTestKit
  module USQualityCoreV010
    class MedicationdispensedeclinedMustSupportTest < Inferno::Test
      include USQualityCoreTestKit::MustSupportTest

      title 'All must support elements are provided in the MedicationDispense resources returned'

      description %(
        This test will look through the MedicationDispense resources
        found previously for the following Must Support and USCDI-flagged elements:

        * MedicationDispense.authorizingPrescription
        * MedicationDispense.context
        * MedicationDispense.dosageInstruction
        * MedicationDispense.dosageInstruction.doseAndRate
        * MedicationDispense.dosageInstruction.doseAndRate.doseQuantity
        * MedicationDispense.dosageInstruction.text
        * MedicationDispense.dosageInstruction.timing
        * MedicationDispense.medication[x]
        * MedicationDispense.performer
        * MedicationDispense.performer.actor
        * MedicationDispense.quantity
        * MedicationDispense.status
        * MedicationDispense.subject
        * MedicationDispense.type
        * MedicationDispense.whenHandedOver

        For ONC USCDI+ Quality requirements, each MedicationDispense must support the following additional elements:

        * MedicationDispense.statusReason[x]
      )

      id :us_quality_core_v010_medicationdispensedeclined_must_support_test

      def resource_type
        'MedicationDispense'
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:medicationdispensedeclined_resources] ||= {}
      end

      run do
        perform_must_support_test(all_scratch_resources)
      end
    end
  end
end
