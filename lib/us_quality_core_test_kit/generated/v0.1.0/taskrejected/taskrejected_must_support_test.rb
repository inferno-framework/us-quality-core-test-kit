require_relative '../../../must_support_test'

module USQualityCoreTestKit
  module USQualityCoreV010
    class TaskrejectedMustSupportTest < Inferno::Test
      include USQualityCoreTestKit::MustSupportTest

      title 'All must support elements are provided in the Task resources returned'

      description %(
        This test will look through the Task resources
        found previously for the following Must Support and USCDI-flagged elements:



        For ONC USCDI+ Quality requirements, each Task must support the following additional elements:

        * Task.basedOn
        * Task.code
        * Task.executionPeriod
        * Task.focus
        * Task.reasonCode
        * Task.status
        * Task.statusReason
      )

      id :us_quality_core_v010_taskrejected_must_support_test

      def resource_type
        'Task'
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:taskrejected_resources] ||= {}
      end

      run do
        perform_must_support_test(all_scratch_resources)
      end
    end
  end
end
