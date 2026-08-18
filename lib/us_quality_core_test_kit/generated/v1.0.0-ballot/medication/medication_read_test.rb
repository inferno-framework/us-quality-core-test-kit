require_relative '../../../read_test'

module USQualityCoreTestKit
  module USQualityCoreV100_BALLOT
    class MedicationReadTest < Inferno::Test
      include USQualityCoreTestKit::ReadTest

      title 'Server returns correct Medication resource from Medication read interaction'

      description 'A server SHALL support the Medication read interaction.'

      id :us_quality_core_v100_ballot_medication_read_test

      def resource_type
        'Medication'
      end

      def scratch_resources
        scratch[:medication_resources] ||= {}
      end

      run do
        perform_read_test(scratch.dig(:references, 'Medication'), delayed_reference: true)
      end
    end
  end
end
