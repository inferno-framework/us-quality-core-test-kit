require_relative '../../../must_support_test'

module USQualityCoreTestKit
  module USQualityCoreV100
    class QuestionnaireResponseMustSupportTest < Inferno::Test
      include USQualityCoreTestKit::MustSupportTest

      title 'All must support elements are provided in the QuestionnaireResponse resources returned'

      description %(
        This test will look through the QuestionnaireResponse resources
        found previously for the following Must Support and USCDI-flagged elements:

        * QuestionnaireResponse.author
        * QuestionnaireResponse.authored
        * QuestionnaireResponse.identifier
        * QuestionnaireResponse.item
        * QuestionnaireResponse.item.answer
        * QuestionnaireResponse.item.answer.item
        * QuestionnaireResponse.item.answer.valueCoding
        * QuestionnaireResponse.item.answer.valueDecimal
        * QuestionnaireResponse.item.answer.valueString
        * QuestionnaireResponse.item.item
        * QuestionnaireResponse.item.linkId
        * QuestionnaireResponse.item.text
        * QuestionnaireResponse.questionnaire
        * QuestionnaireResponse.questionnaire.extension:questionnaireDisplay
        * QuestionnaireResponse.questionnaire.extension:url
        * QuestionnaireResponse.status
        * QuestionnaireResponse.subject
      )

      id :us_quality_core_v100_questionnaire_response_must_support_test

      def resource_type
        'QuestionnaireResponse'
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:questionnaire_response_resources] ||= {}
      end

      run do
        perform_must_support_test(all_scratch_resources)
      end
    end
  end
end
