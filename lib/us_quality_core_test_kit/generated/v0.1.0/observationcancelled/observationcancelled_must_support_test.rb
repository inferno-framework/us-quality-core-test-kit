require_relative '../../../must_support_test'

module USQualityCoreTestKit
  module USQualityCoreV010
    class ObservationcancelledMustSupportTest < Inferno::Test
      include USQualityCoreTestKit::MustSupportTest

      title 'All must support elements are provided in the Observation resources returned'

      description %(
        This test will look through the Observation resources
        found previously for the following Must Support and USCDI-flagged elements:



        For ONC USCDI+ Quality requirements, each Observation must support the following additional elements:

        * Observation.category
        * Observation.code
        * Observation.code.extension:notDoneValueSet
        * Observation.effective[x]
        * Observation.extension:notDoneReason
        * Observation.status
        * Observation.value[x]
      )

      id :us_quality_core_v010_observationcancelled_must_support_test

      def resource_type
        'Observation'
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:observationcancelled_resources] ||= {}
      end

      run do
        perform_must_support_test(all_scratch_resources)
      end
    end
  end
end
