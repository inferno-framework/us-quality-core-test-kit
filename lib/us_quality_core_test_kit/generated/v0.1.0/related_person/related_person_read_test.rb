require_relative '../../../read_test'

module USQualityCoreTestKit
  module USQualityCoreV010
    class RelatedPersonReadTest < Inferno::Test
      include USQualityCoreTestKit::ReadTest

      title 'Server returns correct RelatedPerson resource from RelatedPerson read interaction'

      description 'A server SHALL support the RelatedPerson read interaction.'

      id :us_quality_core_v010_related_person_read_test

      def resource_type
        'RelatedPerson'
      end

      def scratch_resources
        scratch[:related_person_resources] ||= {}
      end

      run do
        perform_read_test(all_scratch_resources)
      end
    end
  end
end
