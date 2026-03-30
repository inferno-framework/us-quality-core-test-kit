require_relative '../../../search_test'
require_relative '../../../generator/group_metadata'
require_relative '../../../search_test_properties'

module USQualityCoreTestKit
  module USQualityCoreV010
    class MedicationadministrationnotdonePatientSearchTest < Inferno::Test
      include USQualityCoreTestKit::SearchTest

      title 'Server returns valid results for MedicationAdministration search by patient'

      description %(
A server SHALL support searching by
patient on the MedicationAdministration resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

If any MedicationAdministration resources use external references to
Medications, the search will be repeated with
`_include=MedicationAdministration:medication`.


      )

      id :us_quality_core_v010_medicationadministrationnotdone_patient_search_test

  

  
      input :patient_ids,
        title: 'Patient IDs',
        description: 'Comma separated list of patient IDs that in sum contain all MUST SUPPORT elements'
  

      def self.properties
        @properties ||= SearchTestProperties.new(
          resource_type: 'MedicationAdministration',
        search_param_names: ['patient'],
        possible_status_search: true,
        test_medication_inclusion: true
        )
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:medicationadministrationnotdone_resources] ||= {}
      end

      run do
        run_search_test
      end
    end
  end
end
