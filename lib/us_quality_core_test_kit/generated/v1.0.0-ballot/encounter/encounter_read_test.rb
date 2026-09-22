require_relative '../../../read_test'

module USQualityCoreTestKit
  module USQualityCoreV100_BALLOT
    class EncounterReadTest < Inferno::Test
      include USQualityCoreTestKit::ReadTest

      title 'Server returns correct Encounter resource from Encounter read interaction'

      description 'A server SHALL support the Encounter read interaction.'

      id :us_quality_core_v100_ballot_encounter_read_test
      verifies_requirements 'us-quality-core-v1.0.0-ballot@CONF-5'

      def resource_type
        'Encounter'
      end

      def scratch_resources
        scratch[:encounter_resources] ||= {}
      end

      run do
        perform_read_test(scratch.dig(:references, 'Encounter'), delayed_reference: true)
      end
    end
  end
end
