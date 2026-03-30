require_relative '../../../must_support_test'

module USQualityCoreTestKit
  module USQualityCoreV010
    class RelatedPersonMustSupportTest < Inferno::Test
      include USQualityCoreTestKit::MustSupportTest

      title 'All must support elements are provided in the RelatedPerson resources returned'

      description %(
        This test will look through the RelatedPerson resources
        found previously for the following Must Support and USCDI-flagged elements:

        * RelatedPerson.active
        * RelatedPerson.address
        * RelatedPerson.name
        * RelatedPerson.patient
        * RelatedPerson.relationship
        * RelatedPerson.telecom
      )

      id :us_quality_core_v010_related_person_must_support_test

      def resource_type
        'RelatedPerson'
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:related_person_resources] ||= {}
      end

      run do
        perform_must_support_test(all_scratch_resources)
      end
    end
  end
end
