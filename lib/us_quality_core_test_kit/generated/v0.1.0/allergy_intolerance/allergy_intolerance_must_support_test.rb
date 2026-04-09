require_relative '../../../must_support_test'

module USQualityCoreTestKit
  module USQualityCoreV010
    class AllergyIntoleranceMustSupportTest < Inferno::Test
      include USQualityCoreTestKit::MustSupportTest

      title 'All must support elements are provided in the AllergyIntolerance resources returned'

      description %(
        This test will look through the AllergyIntolerance resources
        found previously for the following Must Support and USCDI-flagged elements:

        * AllergyIntolerance.clinicalStatus
        * AllergyIntolerance.code
        * AllergyIntolerance.patient
        * AllergyIntolerance.reaction
        * AllergyIntolerance.reaction.manifestation
        * AllergyIntolerance.verificationStatus

        For ONC USCDI+ Quality requirements, each AllergyIntolerance must support the following additional elements:

        * AllergyIntolerance.lastOccurrence
        * AllergyIntolerance.onset[x]
        * AllergyIntolerance.recordedDate
      )

      id :us_quality_core_v010_allergy_intolerance_must_support_test

      def resource_type
        'AllergyIntolerance'
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:allergy_intolerance_resources] ||= {}
      end

      run do
        perform_must_support_test(all_scratch_resources)
      end
    end
  end
end
