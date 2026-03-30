require_relative '../../../reference_resolution_test'

module USQualityCoreTestKit
  module USQualityCoreV010
    class ServicerequestReferenceResolutionTest < Inferno::Test
      include USQualityCoreTestKit::ReferenceResolutionTest

      title 'MustSupport references within ServiceRequest resources are valid'

      description %(
        This test will attempt to read external references provided within elements
        marked as 'MustSupport', if any are available.

        It verifies that at least one external reference for each MustSupport Reference element
        can be accessed by the test client.

        Elements which may provide external references include:

        * ServiceRequest.reasonReference
        * ServiceRequest.requester
        * ServiceRequest.subject
      )

      id :us_quality_core_v010_servicerequest_reference_resolution_test

      def resource_type
        'ServiceRequest'
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:servicerequest_resources] ||= {}
      end

      run do
        perform_reference_resolution_test(scratch_resources[:all])
      end
    end
  end
end
