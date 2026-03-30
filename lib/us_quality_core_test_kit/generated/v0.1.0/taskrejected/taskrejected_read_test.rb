require_relative '../../../read_test'

module USQualityCoreTestKit
  module USQualityCoreV010
    class TaskrejectedReadTest < Inferno::Test
      include USQualityCoreTestKit::ReadTest

      title 'Server returns correct Task resource from Task read interaction'

      description 'A server SHALL support the Task read interaction.'

      id :us_quality_core_v010_taskrejected_read_test

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
