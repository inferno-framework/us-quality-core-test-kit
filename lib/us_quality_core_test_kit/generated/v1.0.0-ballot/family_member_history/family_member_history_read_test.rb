require_relative '../../../read_test'

module USQualityCoreTestKit
  module USQualityCoreV100_BALLOT
    class FamilyMemberHistoryReadTest < Inferno::Test
      include USQualityCoreTestKit::ReadTest

      title 'Server returns correct FamilyMemberHistory resource from FamilyMemberHistory read interaction'

      description 'A server SHALL support the FamilyMemberHistory read interaction.'

      id :us_quality_core_v100_ballot_family_member_history_read_test
      verifies_requirements 'us-quality-core-v1.0.0-ballot@CONF-5'

      def resource_type
        'FamilyMemberHistory'
      end

      def scratch_resources
        scratch[:family_member_history_resources] ||= {}
      end

      run do
        perform_read_test(all_scratch_resources)
      end
    end
  end
end
