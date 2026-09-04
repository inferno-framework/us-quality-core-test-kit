require_relative '../../../search_test'
require_relative '../../../generator/group_metadata'
require_relative '../../../search_test_properties'

module USQualityCoreTestKit
  module USQualityCoreV100_BALLOT
    class UsCoreAdiDocumentreferencePatientTypeSearchTest < Inferno::Test
      include USQualityCoreTestKit::SearchTest

      title 'Server returns valid results for DocumentReference search by patient + type'

      description %(
A server SHALL support searching by
patient + type on the DocumentReference resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.


      )

      id :us_quality_core_v100_ballot_us_core_adi_documentreference_patient_type_search_test
      input :patient_ids,
        title: 'Patient IDs',
        description: 'Comma separated list of patient IDs that in sum contain all MUST SUPPORT elements'
  
      def self.properties
        @properties ||= SearchTestProperties.new(
          resource_type: 'DocumentReference',
        search_param_names: ['patient', 'type'],
        token_search_params: ['type']
        )
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:us_core_adi_documentreference_resources] ||= {}
      end

      run do
        run_search_test
      end
    end
  end
end
