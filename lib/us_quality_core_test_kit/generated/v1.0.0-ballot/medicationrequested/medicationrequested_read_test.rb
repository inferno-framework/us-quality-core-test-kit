require_relative '../../../read_test'

module USQualityCoreTestKit
  module USQualityCoreV100_BALLOT
    class MedicationrequestedReadTest < Inferno::Test
      include USQualityCoreTestKit::ReadTest

      title 'Server returns correct MedicationRequest resource from MedicationRequest read interaction'

      description 'A server SHALL support the MedicationRequest read interaction.'

      id :us_quality_core_v100_ballot_medicationrequested_read_test

      def resource_type
        'MedicationRequest'
      end

      def scratch_resources
        scratch[:medicationrequested_resources] ||= {}
      end

      run do
        perform_read_test(all_scratch_resources)
      end
    end
  end
end
