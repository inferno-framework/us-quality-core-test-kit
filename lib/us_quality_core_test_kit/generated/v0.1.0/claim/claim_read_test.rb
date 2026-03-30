require_relative '../../../read_test'

module USQualityCoreTestKit
  module USQualityCoreV010
    class ClaimReadTest < Inferno::Test
      include USQualityCoreTestKit::ReadTest

      title 'Server returns correct Claim resource from Claim read interaction'

      description 'A server SHALL support the Claim read interaction.'

      id :us_quality_core_v010_claim_read_test

      def resource_type
        'Claim'
      end

      def scratch_resources
        scratch[:claim_resources] ||= {}
      end

      run do
        perform_read_test(all_scratch_resources)
      end
    end
  end
end
