require_relative '../../../search_test'
require_relative '../../../generator/group_metadata'
require_relative '../../../search_test_properties'

module USQualityCoreTestKit
  module USQualityCoreV100_BALLOT
    class ServiceprohibitedPatientCategoryAuthoredSearchTest < Inferno::Test
      include USQualityCoreTestKit::SearchTest

      title 'Server returns valid results for ServiceRequest search by patient + category + authored'

      description %(
A server SHALL support searching by
patient + category + authored on the ServiceRequest resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.


      )

      id :us_quality_core_v100_ballot_serviceprohibited_patient_category_authored_search_test

  

  
      input :patient_ids,
        title: 'Patient IDs',
        description: 'Comma separated list of patient IDs that in sum contain all MUST SUPPORT elements'
  

      def self.properties
        @properties ||= SearchTestProperties.new(
          resource_type: 'ServiceRequest',
        search_param_names: ['patient', 'category', 'authored'],
        token_search_params: ['category'],
        params_with_comparators: ['authored']
        )
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:serviceprohibited_resources] ||= {}
      end

      run do
        run_search_test
      end
    end
  end
end
