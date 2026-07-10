require_relative '../../../read_test'

module USQualityCoreTestKit
  module USQualityCoreV100
    class QuestionnaireResponseReadTest < Inferno::Test
      include USQualityCoreTestKit::ReadTest

      title 'Server returns correct QuestionnaireResponse resource from QuestionnaireResponse read interaction'

      description 'A server SHALL support the QuestionnaireResponse read interaction.'

      id :us_quality_core_v100_questionnaire_response_read_test

      def resource_type
        'QuestionnaireResponse'
      end

      def scratch_resources
        scratch[:questionnaire_response_resources] ||= {}
      end

      run do
        perform_read_test(all_scratch_resources)
      end
    end
  end
end
