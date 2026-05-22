require_relative '../../../search_test'
require_relative '../../../generator/group_metadata'

module USQualityCoreTestKit
  module USCoreV050
    class AdverseEventProvenanceRevincludeSearchTest < Inferno::Test
      include USQualityCoreTestKit::SearchTest

      title 'Server returns Provenance resources from AdverseEvent search by subject + revInclude:Provenance:target'
      description %(
        A server SHALL be capable of supporting _revIncludes:Provenance:target.

        This test will perform a search by subject + revInclude:Provenance:target and
        will pass if a Provenance resource is found in the response.
      %)

      id :us_core_v050_adverse_event_provenance_revinclude_search_test
  
      def properties
        @properties ||= SearchTestProperties.new(
          fixed_value_search: true,
        resource_type: 'AdverseEvent',
        search_param_names: ['subject']
        )
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml')))
      end

      def self.provenance_metadata
        @provenance_metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, '..', 'provenance', 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:adverse_event_resources] ||= {}
      end

      def scratch_provenance_resources
        scratch[:provenance_resources] ||= {}
      end

      run do
        run_provenance_revinclude_search_test
      end
    end
  end
end
