require_relative '../../../must_support_test'

module USQualityCoreTestKit
  module USQualityCoreV100
    class UsCoreTreatmentInterventionPreferenceMustSupportTest < Inferno::Test
      include USQualityCoreTestKit::MustSupportTest

      title 'All must support elements are provided in the Observation resources returned'

      description %(
        This test will look through the Observation resources
        found previously for the following Must Support and USCDI-flagged elements:

        * Observation.category
        * Observation.category:us-core
        * Observation.code.coding.code
        * Observation.effectiveDateTime
        * Observation.performer
        * Observation.status
        * Observation.subject
        * Observation.valueCodeableConcept
        * Observation.valueString
      )

      id :us_quality_core_v100_us_core_treatment_intervention_preference_must_support_test

      def resource_type
        'Observation'
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:us_core_treatment_intervention_preference_resources] ||= {}
      end

      run do
        perform_must_support_test(all_scratch_resources)
      end
    end
  end
end
