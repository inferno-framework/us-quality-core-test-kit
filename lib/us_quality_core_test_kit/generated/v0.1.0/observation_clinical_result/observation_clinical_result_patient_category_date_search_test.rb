require_relative '../../../search_test'
require_relative '../../../generator/group_metadata'
require_relative '../../../search_test_properties'

module USQualityCoreTestKit
  module USQualityCoreV010
    class ObservationClinicalResultPatientCategoryDateSearchTest < Inferno::Test
      include USQualityCoreTestKit::SearchTest

      title 'Server returns valid results for Observation search by patient + category + date'

      description %(
A server SHALL support searching by
patient + category + date on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.


      )

      id :us_quality_core_v010_observation_clinical_result_patient_category_date_search_test

  

  
      input :patient_ids,
        title: 'Patient IDs',
        description: 'Comma separated list of patient IDs that in sum contain all MUST SUPPORT elements'
  

      def self.properties
        @properties ||= SearchTestProperties.new(
          resource_type: 'Observation',
        search_param_names: ['patient', 'category', 'date'],
        possible_status_search: true,
        token_search_params: ['category'],
        params_with_comparators: ['date']
        )
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:observation_clinical_result_resources] ||= {}
      end

      run do
        run_search_test

        scratch_resources[:all]&.reject! { |r| r&.status == 'cancelled' }
        skip_if scratch_resources[:all].nil? || scratch_resources[:all].empty?,
          'Search returned Observation resources, but all have status=cancelled.'
      end
    end
  end
end
