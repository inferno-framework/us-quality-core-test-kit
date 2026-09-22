require_relative '../../../read_test'

module USQualityCoreTestKit
  module USQualityCoreV100_BALLOT
    class CareTeamReadTest < Inferno::Test
      include USQualityCoreTestKit::ReadTest

      title 'Server returns correct CareTeam resource from CareTeam read interaction'

      description 'A server SHALL support the CareTeam read interaction.'

      id :us_quality_core_v100_ballot_care_team_read_test
      verifies_requirements 'us-quality-core-v1.0.0-ballot@CONF-5'

      def resource_type
        'CareTeam'
      end

      def scratch_resources
        scratch[:care_team_resources] ||= {}
      end

      run do
        perform_read_test(all_scratch_resources)
      end
    end
  end
end
