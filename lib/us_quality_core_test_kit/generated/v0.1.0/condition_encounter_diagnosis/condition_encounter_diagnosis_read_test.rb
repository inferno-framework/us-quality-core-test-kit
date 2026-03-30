require_relative '../../../read_test'

module USQualityCoreTestKit
  module USQualityCoreV010
    class ConditionEncounterDiagnosisReadTest < Inferno::Test
      include USQualityCoreTestKit::ReadTest

      title 'Server returns correct Condition resource from Condition read interaction'

      description 'A server SHALL support the Condition read interaction.'

      id :us_quality_core_v010_condition_encounter_diagnosis_read_test

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
