require_relative '../../../must_support_test'

module USQualityCoreTestKit
  module USQualityCoreV010
    class AdverseEventMustSupportTest < Inferno::Test
      include USQualityCoreTestKit::MustSupportTest

      title 'All must support elements are provided in the AdverseEvent resources returned'

      description %(
        This test will look through the AdverseEvent resources
        found previously for the following Must Support and USCDI-flagged elements:



        For ONC USCDI+ Quality requirements, each AdverseEvent must support the following additional elements:

        * AdverseEvent.category
        * AdverseEvent.date
        * AdverseEvent.detected
        * AdverseEvent.event
        * AdverseEvent.recordedDate
        * AdverseEvent.suspectEntity.instance
      )

      id :us_quality_core_v010_adverse_event_must_support_test

      def resource_type
        'AdverseEvent'
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:adverse_event_resources] ||= {}
      end

      run do
        perform_must_support_test(all_scratch_resources)
      end
    end
  end
end
