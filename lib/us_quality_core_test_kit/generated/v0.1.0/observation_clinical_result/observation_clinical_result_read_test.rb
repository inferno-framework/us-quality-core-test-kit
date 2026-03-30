require_relative '../../../read_test'

module USQualityCoreTestKit
  module USQualityCoreV010
    class ObservationClinicalResultReadTest < Inferno::Test
      include USQualityCoreTestKit::ReadTest

      title 'Server returns correct Observation resource from Observation read interaction'

      description 'A server SHALL support the Observation read interaction.'

      id :us_quality_core_v010_observation_clinical_result_read_test

      def resource_type
        'Observation'
      end

      def scratch_resources
        scratch[:observation_clinical_result_resources] ||= {}
      end

      run do
        perform_read_test(all_scratch_resources)
      end
    end
  end
end
