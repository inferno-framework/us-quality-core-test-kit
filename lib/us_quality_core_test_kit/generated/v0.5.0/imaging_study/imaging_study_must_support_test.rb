require_relative '../../../must_support_test'

module USQualityCoreTestKit
  module USQualityCoreV050
    class ImagingStudyMustSupportTest < Inferno::Test
      include USQualityCoreTestKit::MustSupportTest

      title 'All must support elements are provided in the ImagingStudy resources returned'

      description %(
        This test will look through the ImagingStudy resources
        found previously for the following Must Support and USCDI-flagged elements:



        For ONC USCDI+ Quality requirements, each ImagingStudy must support the following additional elements:

        * ImagingStudy.endpoint
      )

      id :us_quality_core_v050_imaging_study_must_support_test

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
        perform_must_support_test(all_scratch_resources)
      end
    end
  end
end
