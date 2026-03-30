require_relative '../../../read_test'

module USQualityCoreTestKit
  module USQualityCoreV010
    class AdverseEventReadTest < Inferno::Test
      include USQualityCoreTestKit::ReadTest

      title 'Server returns correct AdverseEvent resource from AdverseEvent read interaction'

      description 'A server SHALL support the AdverseEvent read interaction.'

      id :us_quality_core_v010_adverse_event_read_test

      def resource_type
        'AdverseEvent'
      end

      def scratch_resources
        scratch[:adverse_event_resources] ||= {}
      end

      run do
        perform_read_test(all_scratch_resources)
      end
    end
  end
end
