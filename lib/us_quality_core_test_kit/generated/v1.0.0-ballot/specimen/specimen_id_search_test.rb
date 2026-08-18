require_relative '../../../search_test'
require_relative '../../../generator/group_metadata'
require_relative '../../../search_test_properties'

module USQualityCoreTestKit
  module USQualityCoreV100_BALLOT
    class SpecimenIdSearchTest < Inferno::Test
      include USQualityCoreTestKit::SearchTest

      title 'Server returns valid results for Specimen search by _id'

      description %(
A server SHALL support searching by
_id on the Specimen resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

Because this is the first search of the sequence, resources in the
response will be used for subsequent tests.

Additionally, this test will check that GET and POST search methods
return the same number of results. Search by POST is required by the
FHIR R4 specification.


      )

      id :us_quality_core_v100_ballot_specimen__id_search_test

  

  

      def self.properties
        @properties ||= SearchTestProperties.new(
          first_search: true,
        resource_type: 'Specimen',
        search_param_names: ['_id'],
        test_post_search: true
        )
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:specimen_resources] ||= {}
      end

      run do
        run_search_test
      end
    end
  end
end
