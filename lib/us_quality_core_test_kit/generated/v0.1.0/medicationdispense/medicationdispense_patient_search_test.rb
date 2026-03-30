require_relative '../../../search_test'
require_relative '../../../generator/group_metadata'
require_relative '../../../search_test_properties'

module USQualityCoreTestKit
  module USQualityCoreV010
    class MedicationdispensePatientSearchTest < Inferno::Test
      include USQualityCoreTestKit::SearchTest

      title 'Server returns valid results for MedicationDispense search by patient'

      description %(
A server SHALL support searching by
patient on the MedicationDispense resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

If any MedicationDispense resources use external references to
Medications, the search will be repeated with
`_include=MedicationDispense:medication`.


      )

      id :us_quality_core_v010_medicationdispense_patient_search_test

  

  
      input :patient_ids,
        title: 'Patient IDs',
        description: 'Comma separated list of patient IDs that in sum contain all MUST SUPPORT elements'
  

      def self.properties
        @properties ||= SearchTestProperties.new(
          resource_type: 'MedicationDispense',
        search_param_names: ['patient'],
        possible_status_search: true,
        test_medication_inclusion: true
        )
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:medicationdispense_resources] ||= {}
      end

      run do
        run_search_test
      end
    end
  end
end
