require_relative '../../../must_support_test'

module USQualityCoreTestKit
  module USQualityCoreV100
    class DeviceMustSupportTest < Inferno::Test
      include USQualityCoreTestKit::MustSupportTest

      title 'All must support elements are provided in the Device resources returned'

      description %(
        This test will look through the Device resources
        found previously for the following Must Support and USCDI-flagged elements:

        * Device.distinctIdentifier
        * Device.expirationDate
        * Device.lotNumber
        * Device.manufactureDate
        * Device.patient
        * Device.serialNumber
        * Device.type
        * Device.udiCarrier
        * Device.udiCarrier.carrierHRF
        * Device.udiCarrier.deviceIdentifier
      )

      id :us_quality_core_v100_device_must_support_test

      def resource_type
        'Device'
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:device_resources] ||= {}
      end

      run do
        perform_must_support_test(all_scratch_resources)
      end
    end
  end
end
