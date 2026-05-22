require_relative '../../../search_test'
require_relative '../../../generator/group_metadata'

module USQualityCoreTestKit
  module USCoreV050
    class UsQualityCoreObservationScreeningAssessmentProvenanceRevincludeSearchTest < Inferno::Test
      include USQualityCoreTestKit::SearchTest

      title 'Server returns Provenance resources from Observation search by patient + category + status + revInclude:Provenance:target'
      description %(
        A server SHALL be capable of supporting _revIncludes:Provenance:target.

        This test will perform a search by patient + category + status + revInclude:Provenance:target and
        will pass if a Provenance resource is found in the response.
      %)

      id :us_core_v050_us_quality_core_observation_screening_assessment_provenance_revinclude_search_test
  
      input :patient_ids,
        title: 'Patient IDs',
        description: 'Comma separated list of patient IDs that in sum contain all MUST SUPPORT elements'
  
      def properties
        @properties ||= SearchTestProperties.new(
          fixed_value_search: true,
        resource_type: 'Observation',
        search_param_names: ['patient', 'category', 'status']
        )
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml')))
      end

      def self.provenance_metadata
        @provenance_metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, '..', 'provenance', 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:us_quality_core_observation_screening_assessment_resources] ||= {}
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
