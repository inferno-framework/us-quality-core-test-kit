require_relative '../../../read_test'

module USQualityCoreTestKit
  module USQualityCoreV100_BALLOT
    class UsCoreBodyTemperatureReadTest < Inferno::Test
      include USQualityCoreTestKit::ReadTest

      title 'Server returns correct Observation resource from Observation read interaction'

      description 'A server SHALL support the Observation read interaction.'

      id :us_quality_core_v100_ballot_us_core_body_temperature_read_test

      def resource_type
        'Observation'
      end

      def scratch_resources
        scratch[:us_core_body_temperature_resources] ||= {}
      end

      run do
        perform_read_test(all_scratch_resources)
      end
    end
  end
end
