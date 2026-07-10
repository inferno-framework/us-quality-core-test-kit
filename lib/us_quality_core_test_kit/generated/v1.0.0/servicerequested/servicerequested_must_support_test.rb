require_relative '../../../must_support_test'

module USQualityCoreTestKit
  module USQualityCoreV100
    class ServicerequestedMustSupportTest < Inferno::Test
      include USQualityCoreTestKit::MustSupportTest

      title 'All must support elements are provided in the ServiceRequest resources returned'

      description %(
        This test will look through the ServiceRequest resources
        found previously for the following Must Support and USCDI-flagged elements:

        * ServiceRequest.authoredOn
        * ServiceRequest.category
        * ServiceRequest.category:us-core
        * ServiceRequest.code
        * ServiceRequest.code.text
        * ServiceRequest.encounter
        * ServiceRequest.intent
        * ServiceRequest.occurrencePeriod
        * ServiceRequest.reasonCode
        * ServiceRequest.reasonReference
        * ServiceRequest.requester
        * ServiceRequest.status
        * ServiceRequest.subject
      )

      id :us_quality_core_v100_servicerequested_must_support_test

      def resource_type
        'ServiceRequest'
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:servicerequested_resources] ||= {}
      end

      run do
        perform_must_support_test(all_scratch_resources)
      end
    end
  end
end
