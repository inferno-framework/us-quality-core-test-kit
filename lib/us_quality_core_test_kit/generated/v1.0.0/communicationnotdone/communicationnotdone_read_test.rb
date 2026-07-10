require_relative '../../../read_test'

module USQualityCoreTestKit
  module USQualityCoreV100
    class CommunicationnotdoneReadTest < Inferno::Test
      include USQualityCoreTestKit::ReadTest

      title 'Server returns correct Communication resource from Communication read interaction'

      description 'A server SHALL support the Communication read interaction.'

      id :us_quality_core_v100_communicationnotdone_read_test

      def resource_type
        'Communication'
      end

      def scratch_resources
        scratch[:communicationnotdone_resources] ||= {}
      end

      run do
        perform_read_test(all_scratch_resources)
      end
    end
  end
end
