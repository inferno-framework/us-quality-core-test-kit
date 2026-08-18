require_relative '../../../search_test'
require_relative '../../../generator/group_metadata'
require_relative '../../../search_test_properties'

module USQualityCoreTestKit
  module USQualityCoreV100_BALLOT
    class CommunicationSubjectSearchTest < Inferno::Test
      include USQualityCoreTestKit::SearchTest

      title 'Server returns valid results for Communication search by subject'

      description %(
A server SHALL support searching by
subject on the Communication resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

Because this is the first search of the sequence, resources in the
response will be used for subsequent tests.

Additionally, this test will check that GET and POST search methods
return the same number of results. Search by POST is required by the
FHIR R4 specification.


      )

      id :us_quality_core_v100_ballot_communication_subject_search_test

  optional

  
      input :patient_ids,
        title: 'Patient IDs',
        description: 'Comma separated list of patient IDs that in sum contain all MUST SUPPORT elements'
  

      def self.properties
        @properties ||= SearchTestProperties.new(
          first_search: true,
        resource_type: 'Communication',
        search_param_names: ['subject'],
        saves_delayed_references: true,
        possible_status_search: true,
        test_post_search: true
        )
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:communication_resources] ||= {}
      end

      run do
        run_search_test
      end
    end
  end
end
