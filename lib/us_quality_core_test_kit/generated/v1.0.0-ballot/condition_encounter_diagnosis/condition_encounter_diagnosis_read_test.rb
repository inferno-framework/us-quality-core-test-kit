require_relative '../../../read_test'

module USQualityCoreTestKit
  module USQualityCoreV100_BALLOT
    class ConditionEncounterDiagnosisReadTest < Inferno::Test
      include USQualityCoreTestKit::ReadTest

      title 'Server returns correct Condition resource from Condition read interaction'

      description 'A server SHALL support the Condition read interaction.'

      id :us_quality_core_v100_ballot_condition_encounter_diagnosis_read_test
      verifies_requirements 'us-quality-core-v1.0.0-ballot@CONF-5'

      def resource_type
        'Condition'
      end

      def scratch_resources
        scratch[:condition_encounter_diagnosis_resources] ||= {}
      end

      run do
        perform_read_test(all_scratch_resources)
      end
    end
  end
end
