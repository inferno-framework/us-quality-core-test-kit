require_relative '../../../must_support_test'

module USQualityCoreTestKit
  module USQualityCoreV010
    class FamilyMemberHistoryMustSupportTest < Inferno::Test
      include USQualityCoreTestKit::MustSupportTest

      title 'All must support elements are provided in the FamilyMemberHistory resources returned'

      description %(
        This test will look through the FamilyMemberHistory resources
        found previously for the following Must Support and USCDI-flagged elements:



        For ONC USCDI+ Quality requirements, each FamilyMemberHistory must support the following additional elements:

        * FamilyMemberHistory.condition.code
      )

      id :us_quality_core_v010_family_member_history_must_support_test

      def resource_type
        'FamilyMemberHistory'
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:family_member_history_resources] ||= {}
      end

      run do
        perform_must_support_test(all_scratch_resources)
      end
    end
  end
end
