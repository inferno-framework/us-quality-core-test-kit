require_relative '../../../read_test'

module USQualityCoreTestKit
  module USQualityCoreV010
    class ImagingStudyReadTest < Inferno::Test
      include USQualityCoreTestKit::ReadTest

      title 'Server returns correct ImagingStudy resource from ImagingStudy read interaction'

      description 'A server SHALL support the ImagingStudy read interaction.'

      id :us_quality_core_v010_imaging_study_read_test

      def resource_type
        'ImagingStudy'
      end

      def scratch_resources
        scratch[:imaging_study_resources] ||= {}
      end

      run do
        perform_read_test(all_scratch_resources)
      end
    end
  end
end
