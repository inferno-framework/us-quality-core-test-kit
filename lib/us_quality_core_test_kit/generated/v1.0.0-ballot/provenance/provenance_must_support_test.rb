require_relative '../../../must_support_test'

module USQualityCoreTestKit
  module USQualityCoreV100_BALLOT
    class ProvenanceMustSupportTest < Inferno::Test
      include USQualityCoreTestKit::MustSupportTest

      title 'All must support elements are provided in the Provenance resources returned'

      description %(
        This test will look through the Provenance resources
        found previously for the following Must Support and USCDI-flagged elements:

        * Provenance.agent
        * Provenance.agent.onBehalfOf
        * Provenance.agent.type
        * Provenance.agent.who
        * Provenance.agent:ProvenanceAuthor
        * Provenance.agent:ProvenanceAuthor.onBehalfOf
        * Provenance.agent:ProvenanceAuthor.type
        * Provenance.agent:ProvenanceAuthor.who
        * Provenance.agent:ProvenanceTransmitter
        * Provenance.agent:ProvenanceTransmitter.onBehalfOf
        * Provenance.agent:ProvenanceTransmitter.type
        * Provenance.agent:ProvenanceTransmitter.who
        * Provenance.recorded
        * Provenance.target
        * Provenance.target.reference
      )

      id :us_quality_core_v100_ballot_provenance_must_support_test

      def resource_type
        'Provenance'
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:provenance_resources] ||= {}
      end

      run do
        perform_must_support_test(all_scratch_resources)
      end
    end
  end
end
