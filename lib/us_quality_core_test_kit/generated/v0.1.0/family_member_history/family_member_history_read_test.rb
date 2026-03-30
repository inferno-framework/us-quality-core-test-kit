require_relative '../../../read_test'

module USQualityCoreTestKit
  module USQualityCoreV010
    class FamilyMemberHistoryReadTest < Inferno::Test
      include USQualityCoreTestKit::ReadTest

      title 'Server returns correct FamilyMemberHistory resource from FamilyMemberHistory read interaction'

      description 'A server SHALL support the FamilyMemberHistory read interaction.'

      id :us_quality_core_v010_family_member_history_read_test

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
