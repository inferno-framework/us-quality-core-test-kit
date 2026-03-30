require_relative '../../../reference_resolution_test'

module USQualityCoreTestKit
  module USQualityCoreV010
    class ClaimReferenceResolutionTest < Inferno::Test
      include USQualityCoreTestKit::ReferenceResolutionTest

      title 'MustSupport references within Claim resources are valid'

      description %(
        This test will attempt to read external references provided within elements
        marked as 'MustSupport', if any are available.

        It verifies that at least one external reference for each MustSupport Reference element
        can be accessed by the test client.

        Elements which may provide external references include:

        * Claim.diagnosis.diagnosis[x]
      )

      id :us_quality_core_v010_claim_reference_resolution_test

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
        perform_reference_resolution_test(scratch_resources[:all])
      end
    end
  end
end
