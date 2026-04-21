require_relative '../../../must_support_test'

module USQualityCoreTestKit
  module USQualityCoreV010
    class MedicationrequestMustSupportTest < Inferno::Test
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
        * MedicationRequest.dosageInstruction.text
        * MedicationRequest.dosageInstruction.timing
        * MedicationRequest.encounter
        * MedicationRequest.extension:medicationAdherence
        * MedicationRequest.intent
        * MedicationRequest.medication[x]
        * MedicationRequest.reportedReference
        * MedicationRequest.requester
        * MedicationRequest.status
        * MedicationRequest.subject

        For ONC USCDI+ Quality requirements, each MedicationRequest must support the following additional elements:

        * MedicationRequest.dispenseRequest.expectedSupplyDuration
        * MedicationRequest.dispenseRequest.validityPeriod
        * MedicationRequest.dosageInstruction.asNeeded[x]
        * MedicationRequest.dosageInstruction.route
        * MedicationRequest.dosageInstruction.timing.repeat
        * MedicationRequest.dosageInstruction.timing.repeat.bounds[x]
        * MedicationRequest.dosageInstruction.timing.repeat.frequency
        * MedicationRequest.dosageInstruction.timing.repeat.frequencyMax
        * MedicationRequest.dosageInstruction.timing.repeat.period
        * MedicationRequest.dosageInstruction.timing.repeat.periodMax
        * MedicationRequest.dosageInstruction.timing.repeat.periodUnit
        * MedicationRequest.reasonCode
        * MedicationRequest.reasonReference
      )

      id :us_quality_core_v010_medicationrequest_must_support_test

      def resource_type
        'MedicationRequest'
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:medicationrequest_resources] ||= {}
      end

      run do
        perform_must_support_test(all_scratch_resources)
      end
    end
  end
end
