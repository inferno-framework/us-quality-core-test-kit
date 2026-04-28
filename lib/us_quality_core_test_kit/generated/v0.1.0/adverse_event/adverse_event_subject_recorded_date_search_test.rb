require_relative '../../../search_test'
require_relative '../../../generator/group_metadata'
require_relative '../../../search_test_properties'

module USQualityCoreTestKit
  module USQualityCoreV010
    class AdverseEventSubjectRecordedDateSearchTest < Inferno::Test
      include USQualityCoreTestKit::SearchTest

      title 'Server returns valid results for AdverseEvent search by subject + recorded-date'

      description %(
A server SHALL support searching by
subject + recorded-date on the AdverseEvent resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.


      )

      id :us_quality_core_v010_adverse_event_subject_recorded_date_search_test

  

  
      input :patient_ids,
        title: 'Patient IDs',
        description: 'Comma separated list of patient IDs that in sum contain all MUST SUPPORT elements'
  

      def self.properties
        @properties ||= SearchTestProperties.new(
          resource_type: 'AdverseEvent',
        search_param_names: ['subject', 'recorded-date'],
        params_with_comparators: ['recorded-date']
        )
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:adverse_event_resources] ||= {}
      end

      run do
        run_search_test
      end
    end
  end
end
