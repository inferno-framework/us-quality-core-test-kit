require_relative '../../../reference_resolution_test'

module USQualityCoreTestKit
  module USQualityCoreV100_BALLOT
    class ImagingStudyReferenceResolutionTest < Inferno::Test
      include USQualityCoreTestKit::ReferenceResolutionTest

      title 'MustSupport references within ImagingStudy resources are valid'

      description %(
        This test will attempt to read external references provided within elements
        marked as 'MustSupport', if any are available.

        It verifies that at least one external reference for each MustSupport Reference element
        can be accessed by the test client.

        Elements which may provide external references include:

        * ImagingStudy.interpreter
        * ImagingStudy.series.performer.actor
      )

      id :us_quality_core_v100_ballot_imaging_study_reference_resolution_test

      def resource_type
        'ImagingStudy'
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:imaging_study_resources] ||= {}
      end

      run do
        perform_reference_resolution_test(scratch_resources[:all])
      end
    end
  end
end
