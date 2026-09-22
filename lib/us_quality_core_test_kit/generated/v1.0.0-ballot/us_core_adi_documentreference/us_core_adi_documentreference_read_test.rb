require_relative '../../../read_test'

module USQualityCoreTestKit
  module USQualityCoreV100_BALLOT
    class UsCoreAdiDocumentreferenceReadTest < Inferno::Test
      include USQualityCoreTestKit::ReadTest

      title 'Server returns correct DocumentReference resource from DocumentReference read interaction'

      description 'A server SHALL support the DocumentReference read interaction.'

      id :us_quality_core_v100_ballot_us_core_adi_documentreference_read_test
      verifies_requirements 'us-quality-core-v1.0.0-ballot@CONF-5'

      def resource_type
        'DocumentReference'
      end

      def scratch_resources
        scratch[:us_core_adi_documentreference_resources] ||= {}
      end

      run do
        perform_read_test(all_scratch_resources)
      end
    end
  end
end
