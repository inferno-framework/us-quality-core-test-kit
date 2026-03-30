require_relative '../../../search_test'
require_relative '../../../generator/group_metadata'
require_relative '../../../search_test_properties'

module USQualityCoreTestKit
  module USQualityCoreV010
    class MedicationadministrationPatientStatusSearchTest < Inferno::Test
      include USQualityCoreTestKit::SearchTest

      title 'Server returns valid results for MedicationAdministration search by patient + status'

      description %(
A server SHALL support searching by
patient + status on the MedicationAdministration resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

If any MedicationAdministration resources use external references to
Medications, the search will be repeated with
`_include=MedicationAdministration:medication`.

This test verifies that the server supports searching by reference using
the form `patient=[id]` as well as `patient=Patient/[id]`. The two
different forms are expected to return the same number of results.

Because this is the first search of the sequence, resources in the
response will be used for subsequent tests.

Additionally, this test will check that GET and POST search methods
return the same number of results. Search by POST is required by the
FHIR R4 specification.


      )

      id :us_quality_core_v010_medicationadministration_patient_status_search_test

  

  
      input :patient_ids,
        title: 'Patient IDs',
        description: 'Comma separated list of patient IDs that in sum contain all MUST SUPPORT elements'
  

      def self.properties
        @properties ||= SearchTestProperties.new(
          first_search: true,
        fixed_value_search: true,
        resource_type: 'MedicationAdministration',
        search_param_names: ['patient', 'status'],
        saves_delayed_references: true,
        test_medication_inclusion: true,
        test_reference_variants: true,
        test_post_search: true
        )
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:medicationadministration_resources] ||= {}
      end

      run do
        run_search_test
      end
    end
  end
end
