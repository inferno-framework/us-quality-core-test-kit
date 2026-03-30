require_relative '../../../search_test'
require_relative '../../../generator/group_metadata'
require_relative '../../../search_test_properties'

module USQualityCoreTestKit
  module USQualityCoreV010
    class MedicationnotrequestedPatientIntentSearchTest < Inferno::Test
      include USQualityCoreTestKit::SearchTest

      title 'Server returns valid results for MedicationRequest search by patient + intent'

      description %(
A server SHALL support searching by
patient + intent on the MedicationRequest resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

If any MedicationRequest resources use external references to
Medications, the search will be repeated with
`_include=MedicationRequest:medication`.

This test verifies that the server supports searching by reference using
the form `patient=[id]` as well as `patient=Patient/[id]`. The two
different forms are expected to return the same number of results.

Because this is the first search of the sequence, resources in the
response will be used for subsequent tests.

Additionally, this test will check that GET and POST search methods
return the same number of results. Search by POST is required by the
FHIR R4 specification.


      )

      id :us_quality_core_v010_medicationnotrequested_patient_intent_search_test

  

  
      input :patient_ids,
        title: 'Patient IDs',
        description: 'Comma separated list of patient IDs that in sum contain all MUST SUPPORT elements'
  

      def self.properties
        @properties ||= SearchTestProperties.new(
          first_search: true,
        fixed_value_search: true,
        resource_type: 'MedicationRequest',
        search_param_names: ['patient', 'intent'],
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
        scratch[:medicationnotrequested_resources] ||= {}
      end

      run do
        run_search_test

        scratch_resources[:all]&.select! { |r| r&.doNotPerform }
        skip_if scratch_resources[:all].nil? || scratch_resources[:all].empty?,
          'Search returned MedicationRequest resources, but none have doNotPerform=true.'
      end
    end
  end
end
