require_relative '../../../search_test'
require_relative '../../../generator/group_metadata'
require_relative '../../../search_test_properties'

module USQualityCoreTestKit
  module USQualityCoreV010
    class MedicationnotrequestedPatientIntentDoNotPerformSearchTest < Inferno::Test
      include USQualityCoreTestKit::SearchTest

      title 'Server returns valid results for MedicationRequest search by patient + intent + do-not-perform'

      description %(
A server SHALL support searching by
patient + intent + do-not-perform on the MedicationRequest resource. This test
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

      id :us_quality_core_v010_medicationnotrequested_patient_intent_do_not_perform_search_test

  

  
      input :patient_ids,
        title: 'Patient IDs',
        description: 'Comma separated list of patient IDs that in sum contain all MUST SUPPORT elements'
  

      def self.properties
        @properties ||= SearchTestProperties.new(
          first_search: true,
        fixed_value_search: true,
        resource_type: 'MedicationRequest',
        search_param_names: ['patient', 'intent', 'do-not-perform'],
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

      def fixed_value_search_param_values
        [
          { "intent" => "proposal", "do-not-perform" => "true" },
          { "intent" => "plan", "do-not-perform" => "true" },
          { "intent" => "order", "do-not-perform" => "true" },
          { "intent" => "original-order", "do-not-perform" => "true" },
          { "intent" => "reflex-order", "do-not-perform" => "true" },
          { "intent" => "filler-order", "do-not-perform" => "true" },
          { "intent" => "instance-order", "do-not-perform" => "true" },
          { "intent" => "option", "do-not-perform" => "true" }
        ]
      end

      def fixed_value_search_params(values, patient_id)
        search_param_names.each_with_object({}) do |name, params|
          params[name] = patient_id_param?(name) ? patient_id : values[name]
        end
      end

      run do
        run_search_test
      end
    end
  end
end
