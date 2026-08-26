require_relative '../../../must_support_test'

module USQualityCoreTestKit
  module USQualityCoreV100_BALLOT
    class MedicationrequestedMustSupportTest < Inferno::Test
      include USQualityCoreTestKit::MustSupportTest

      title 'All must support elements are provided in the MedicationRequest resources returned'

      description %(
        This test will look through the MedicationRequest resources
        found previously for the following Must Support and USCDI-flagged elements:

        * MedicationRequest.authoredOn
        * MedicationRequest.category
        * MedicationRequest.category:us-core
        * MedicationRequest.dispenseRequest
        * MedicationRequest.dispenseRequest.numberOfRepeatsAllowed
        * MedicationRequest.dispenseRequest.quantity
        * MedicationRequest.dosageInstruction
        * MedicationRequest.dosageInstruction.doseAndRate
        * MedicationRequest.dosageInstruction.doseAndRate.doseQuantity
        * MedicationRequest.dosageInstruction.route
        * MedicationRequest.dosageInstruction.text
        * MedicationRequest.dosageInstruction.timing
        * MedicationRequest.encounter
        * MedicationRequest.intent
        * MedicationRequest.medication[x]
        * MedicationRequest.reportedBoolean or MedicationRequest.reportedReference
        * MedicationRequest.reported[x]:reportedReference
        * MedicationRequest.requester
        * MedicationRequest.status
        * MedicationRequest.subject

        For ONC USCDI+ Quality requirements, each MedicationRequest must support the following additional elements:

        * MedicationRequest.dispenseRequest.expectedSupplyDuration
        * MedicationRequest.dispenseRequest.validityPeriod
        * MedicationRequest.doNotPerform
        * MedicationRequest.dosageInstruction.asNeeded[x]
        * MedicationRequest.dosageInstruction.timing.repeat
        * MedicationRequest.dosageInstruction.timing.repeat.bounds[x]
        * MedicationRequest.dosageInstruction.timing.repeat.frequency
        * MedicationRequest.dosageInstruction.timing.repeat.frequencyMax
        * MedicationRequest.dosageInstruction.timing.repeat.period
        * MedicationRequest.dosageInstruction.timing.repeat.periodMax
        * MedicationRequest.dosageInstruction.timing.repeat.periodUnit
        * MedicationRequest.extension:medicationAdherence
        * MedicationRequest.medication[x].extension:codeOptions
        * MedicationRequest.reasonCode or MedicationRequest.reasonReference
      )

      id :us_quality_core_v100_ballot_medicationrequested_must_support_test

      def resource_type
        'MedicationRequest'
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:medicationrequested_resources] ||= {}
      end

      run do
        perform_must_support_test(all_scratch_resources)
      end
    end
  end
end
