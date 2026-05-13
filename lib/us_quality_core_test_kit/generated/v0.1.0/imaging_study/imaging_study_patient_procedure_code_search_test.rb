require_relative '../../../search_test'
require_relative '../../../generator/group_metadata'
require_relative '../../../search_test_properties'

module USQualityCoreTestKit
  module USQualityCoreV010
    class ImagingStudyPatientProcedureCodeSearchTest < Inferno::Test
      include USQualityCoreTestKit::SearchTest

      title 'Server returns valid results for ImagingStudy search by patient + procedure-code'

      description %(
A server SHALL support searching by
patient + procedure-code on the ImagingStudy resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.


      )

      id :us_quality_core_v010_imaging_study_patient_procedure_code_search_test

  optional

  
      input :patient_ids,
        title: 'Patient IDs',
        description: 'Comma separated list of patient IDs that in sum contain all MUST SUPPORT elements'
  

      def self.properties
        @properties ||= SearchTestProperties.new(
          resource_type: 'ImagingStudy',
        search_param_names: ['patient', 'procedure-code']
        )
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:imaging_study_resources] ||= {}
      end

      run do
        run_search_test
      end
    end
  end
end
