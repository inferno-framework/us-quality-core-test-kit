require_relative '../../../read_test'

module USQualityCoreTestKit
  module USQualityCoreV100_BALLOT
    class DeviceprohibitedReadTest < Inferno::Test
      include USQualityCoreTestKit::ReadTest

      title 'Server returns correct DeviceRequest resource from DeviceRequest read interaction'

      description 'A server SHALL support the DeviceRequest read interaction.'

      id :us_quality_core_v100_ballot_deviceprohibited_read_test

      def resource_type
        'DeviceRequest'
      end

      def scratch_resources
        scratch[:deviceprohibited_resources] ||= {}
      end

      run do
        perform_read_test(all_scratch_resources)
      end
    end
  end
end
