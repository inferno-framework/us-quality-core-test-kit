require_relative '../../../must_support_test'

module USQualityCoreTestKit
  module USQualityCoreV100_BALLOT
    class ProceduredoneMustSupportTest < Inferno::Test
      include USQualityCoreTestKit::MustSupportTest

      title 'All must support elements are provided in the Procedure resources returned'

      description %(
        This test will look through the Procedure resources
        found previously for the following Must Support and USCDI-flagged elements:

        * Procedure.basedOn
        * Procedure.code
        * Procedure.encounter
        * Procedure.performedDateTime
        * Procedure.performer
        * Procedure.status
        * Procedure.subject

        For ONC USCDI+ Quality requirements, each Procedure must support the following additional elements:

        * Procedure.partOf
        * Procedure.performer.actor
        * Procedure.reasonCode or Procedure.reasonReference
        * Procedure.statusReason
      )

      id :us_quality_core_v100_ballot_proceduredone_must_support_test

      def resource_type
        'Procedure'
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:proceduredone_resources] ||= {}
      end

      run do
        perform_must_support_test(all_scratch_resources)
      end
    end
  end
end
