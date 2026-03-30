require_relative '../../../must_support_test'

module USQualityCoreTestKit
  module USQualityCoreV010
    class ConditionEncounterDiagnosisMustSupportTest < Inferno::Test
      include USQualityCoreTestKit::MustSupportTest

      title 'All must support elements are provided in the Condition resources returned'

      description %(
        This test will look through the Condition resources
        found previously for the following Must Support and USCDI-flagged elements:

        * Condition.abatementDateTime
        * Condition.category
        * Condition.category:us-core
        * Condition.clinicalStatus
        * Condition.code
        * Condition.encounter
        * Condition.extension:assertedDate
        * Condition.onsetDateTime
        * Condition.recordedDate
        * Condition.subject
        * Condition.verificationStatus
      )

      id :us_quality_core_v010_condition_encounter_diagnosis_must_support_test

      def resource_type
        'Condition'
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:condition_encounter_diagnosis_resources] ||= {}
      end

      run do
        perform_must_support_test(all_scratch_resources)
      end
    end
  end
end
