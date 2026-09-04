require_relative '../../../must_support_test'

module USQualityCoreTestKit
  module USQualityCoreV100_BALLOT
    class CommunicationMustSupportTest < Inferno::Test
      include USQualityCoreTestKit::MustSupportTest

      title 'All must support elements are provided in the Communication resources returned'

      description %(
        This test will look through the Communication resources
        found previously for the following Must Support and USCDI-flagged elements:



        For ONC USCDI+ Quality requirements, each Communication must support the following additional elements:

        * Communication.category
        * Communication.sent
        * Communication.status
        * Communication.subject
        * Communication.topic
        * Communication.topic.extension:codeOptions
      )

      id :us_quality_core_v100_ballot_communication_must_support_test

      def resource_type
        'Communication'
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:communication_resources] ||= {}
      end

      run do
        perform_must_support_test(all_scratch_resources)
      end
    end
  end
end
