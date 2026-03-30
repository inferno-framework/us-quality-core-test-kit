require_relative '../../../read_test'

module USQualityCoreTestKit
  module USQualityCoreV010
    class ServicerequestReadTest < Inferno::Test
      include USQualityCoreTestKit::ReadTest

      title 'Server returns correct ServiceRequest resource from ServiceRequest read interaction'

      description 'A server SHALL support the ServiceRequest read interaction.'

      id :us_quality_core_v010_servicerequest_read_test

      def resource_type
        'ServiceRequest'
      end

      def scratch_resources
        scratch[:servicerequest_resources] ||= {}
      end

      run do
        perform_read_test(all_scratch_resources)
      end
    end
  end
end
