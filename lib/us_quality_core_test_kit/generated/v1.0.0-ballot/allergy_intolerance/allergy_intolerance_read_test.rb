require_relative '../../../read_test'

module USQualityCoreTestKit
  module USQualityCoreV100_BALLOT
    class AllergyIntoleranceReadTest < Inferno::Test
      include USQualityCoreTestKit::ReadTest

      title 'Server returns correct AllergyIntolerance resource from AllergyIntolerance read interaction'

      description 'A server SHALL support the AllergyIntolerance read interaction.'

      id :us_quality_core_v100_ballot_allergy_intolerance_read_test
      verifies_requirements 'us-quality-core-v1.0.0-ballot@CONF-5'

      def resource_type
        'AllergyIntolerance'
      end

      def scratch_resources
        scratch[:allergy_intolerance_resources] ||= {}
      end

      run do
        perform_read_test(all_scratch_resources)
      end
    end
  end
end
