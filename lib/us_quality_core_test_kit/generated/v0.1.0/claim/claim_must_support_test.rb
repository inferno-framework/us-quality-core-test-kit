require_relative '../../../must_support_test'

module USQualityCoreTestKit
  module USQualityCoreV010
    class ClaimMustSupportTest < Inferno::Test
      include USQualityCoreTestKit::MustSupportTest

      title 'All must support elements are provided in the Claim resources returned'

      description %(
        This test will look through the Claim resources
        found previously for the following Must Support and USCDI-flagged elements:



        For ONC USCDI+ Quality requirements, each Claim must support the following additional elements:

        * Claim.diagnosis.diagnosis[x]
        * Claim.diagnosis.onAdmission
      )

      id :us_quality_core_v010_claim_must_support_test

      def resource_type
        'Claim'
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:claim_resources] ||= {}
      end

      run do
        perform_must_support_test(all_scratch_resources)
      end
    end
  end
end
