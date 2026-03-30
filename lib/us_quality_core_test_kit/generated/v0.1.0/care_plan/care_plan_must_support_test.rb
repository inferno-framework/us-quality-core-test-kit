require_relative '../../../must_support_test'

module USQualityCoreTestKit
  module USQualityCoreV010
    class CarePlanMustSupportTest < Inferno::Test
      include USQualityCoreTestKit::MustSupportTest

      title 'All must support elements are provided in the CarePlan resources returned'

      description %(
        This test will look through the CarePlan resources
        found previously for the following Must Support and USCDI-flagged elements:

        * CarePlan.category
        * CarePlan.category:AssessPlan
        * CarePlan.intent
        * CarePlan.status
        * CarePlan.subject
        * CarePlan.text
        * CarePlan.text.div
        * CarePlan.text.status
      )

      id :us_quality_core_v010_care_plan_must_support_test

      def resource_type
        'CarePlan'
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:care_plan_resources] ||= {}
      end

      run do
        perform_must_support_test(all_scratch_resources)
      end
    end
  end
end
