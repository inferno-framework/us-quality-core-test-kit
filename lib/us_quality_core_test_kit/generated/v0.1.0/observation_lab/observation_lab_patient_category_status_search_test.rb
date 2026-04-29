require_relative '../../../search_test'
require_relative '../../../generator/group_metadata'
require_relative '../../../search_test_properties'

module USQualityCoreTestKit
  module USQualityCoreV010
    class ObservationLabPatientCategoryStatusSearchTest < Inferno::Test
      include USQualityCoreTestKit::SearchTest

      title 'Server returns valid results for Observation search by patient + category + status'

      description %(
A server SHALL support searching by
patient + category + status on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

This test verifies that the server supports searching by reference using
the form `patient=[id]` as well as `patient=Patient/[id]`. The two
different forms are expected to return the same number of results.

Because this is the first search of the sequence, resources in the
response will be used for subsequent tests.

Additionally, this test will check that GET and POST search methods
return the same number of results. Search by POST is required by the
FHIR R4 specification.


      )

      id :us_quality_core_v010_observation_lab_patient_category_status_search_test

  

  
      input :patient_ids,
        title: 'Patient IDs',
        description: 'Comma separated list of patient IDs that in sum contain all MUST SUPPORT elements'
  

      def self.properties
        @properties ||= SearchTestProperties.new(
          first_search: true,
        fixed_value_search: true,
        resource_type: 'Observation',
        search_param_names: ['patient', 'category', 'status'],
        token_search_params: ['category'],
        test_reference_variants: true,
        test_post_search: true
        )
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:observation_lab_resources] ||= {}
      end

      def fixed_value_search_param_values
        [
          { "category" => "laboratory", "status" => "registered" },
          { "category" => "laboratory", "status" => "preliminary" },
          { "category" => "laboratory", "status" => "final" },
          { "category" => "laboratory", "status" => "amended" },
          { "category" => "laboratory", "status" => "corrected" },
          { "category" => "laboratory", "status" => "entered-in-error" },
          { "category" => "laboratory", "status" => "unknown" }
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
