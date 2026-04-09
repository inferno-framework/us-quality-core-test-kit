require_relative '../../../must_support_test'

module USQualityCoreTestKit
  module USQualityCoreV010
    class DevicenotrequestedMustSupportTest < Inferno::Test
      include USQualityCoreTestKit::MustSupportTest

      title 'All must support elements are provided in the DeviceRequest resources returned'

      description %(
        This test will look through the DeviceRequest resources
        found previously for the following Must Support and USCDI-flagged elements:



        For ONC USCDI+ Quality requirements, each DeviceRequest must support the following additional elements:

        * DeviceRequest.code[x]
      )

      id :us_quality_core_v010_devicenotrequested_must_support_test

      def resource_type
        'DeviceRequest'
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:devicenotrequested_resources] ||= {}
      end

      run do
        perform_must_support_test(all_scratch_resources)
      end
    end
  end
end
