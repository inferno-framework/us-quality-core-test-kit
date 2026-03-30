require_relative '../../../must_support_test'

module USQualityCoreTestKit
  module USQualityCoreV010
    class GoalMustSupportTest < Inferno::Test
      include USQualityCoreTestKit::MustSupportTest

      title 'All must support elements are provided in the Goal resources returned'

      description %(
        This test will look through the Goal resources
        found previously for the following Must Support and USCDI-flagged elements:

        * Goal.description
        * Goal.lifecycleStatus
        * Goal.startDate
        * Goal.subject
        * Goal.target
        * Goal.target.dueDate
      )

      id :us_quality_core_v010_goal_must_support_test

      def resource_type
        'Goal'
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:goal_resources] ||= {}
      end

      run do
        perform_must_support_test(all_scratch_resources)
      end
    end
  end
end
