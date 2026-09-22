require_relative '../../../read_test'

module USQualityCoreTestKit
  module USQualityCoreV100_BALLOT
    class TaskrejectedReadTest < Inferno::Test
      include USQualityCoreTestKit::ReadTest

      title 'Server returns correct Task resource from Task read interaction'

      description 'A server SHALL support the Task read interaction.'

      id :us_quality_core_v100_ballot_taskrejected_read_test
      verifies_requirements 'us-quality-core-v1.0.0-ballot@CONF-5'

      def resource_type
        'Task'
      end

      def scratch_resources
        scratch[:taskrejected_resources] ||= {}
      end

      run do
        perform_read_test(all_scratch_resources)
      end
    end
  end
end
