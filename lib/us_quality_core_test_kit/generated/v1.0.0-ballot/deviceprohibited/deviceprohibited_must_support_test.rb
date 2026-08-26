require_relative '../../../must_support_test'

module USQualityCoreTestKit
  module USQualityCoreV100_BALLOT
    class DeviceprohibitedMustSupportTest < Inferno::Test
      include USQualityCoreTestKit::MustSupportTest

      title 'All must support elements are provided in the DeviceRequest resources returned'

      description %(
        This test will look through the DeviceRequest resources
        found previously for the following Must Support and USCDI-flagged elements:



        For ONC USCDI+ Quality requirements, each DeviceRequest must support the following additional elements:

        * DeviceRequest.authoredOn
        * DeviceRequest.code[x]
        * DeviceRequest.code[x]:codeCodeableConcept.extension:codeOptions
        * DeviceRequest.intent
        * DeviceRequest.modifierExtension:doNotPerform
        * DeviceRequest.reasonCode
        * DeviceRequest.requester
        * DeviceRequest.status
      )

      id :us_quality_core_v100_ballot_deviceprohibited_must_support_test

      def resource_type
        'DeviceRequest'
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:deviceprohibited_resources] ||= {}
      end

      run do
        perform_must_support_test(all_scratch_resources)
      end
    end
  end
end
