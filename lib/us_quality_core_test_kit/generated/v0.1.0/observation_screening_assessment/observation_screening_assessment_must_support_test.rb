require_relative '../../../must_support_test'

module USQualityCoreTestKit
  module USQualityCoreV010
    class ObservationScreeningAssessmentMustSupportTest < Inferno::Test
      include USQualityCoreTestKit::MustSupportTest

      title 'All must support elements are provided in the Observation resources returned'

      description %(
        This test will look through the Observation resources
        found previously for the following Must Support and USCDI-flagged elements:

        * Observation.category
        * Observation.category:screening-assessment
        * Observation.category:survey
        * Observation.code
        * Observation.dataAbsentReason
        * Observation.derivedFrom
        * Observation.effectiveDateTime
        * Observation.hasMember
        * Observation.performer
        * Observation.status
        * Observation.subject
        * Observation.valueCodeableConcept
        * Observation.valueQuantity
        * Observation.valueString
      )

      id :us_quality_core_v010_observation_screening_assessment_must_support_test

      def resource_type
        'Observation'
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:observation_screening_assessment_resources] ||= {}
      end

      run do
        perform_must_support_test(all_scratch_resources)
      end
    end
  end
end
