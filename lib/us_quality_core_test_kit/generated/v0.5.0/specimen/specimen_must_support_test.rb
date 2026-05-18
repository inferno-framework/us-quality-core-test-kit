require_relative '../../../must_support_test'

module USQualityCoreTestKit
  module USQualityCoreV050
    class SpecimenMustSupportTest < Inferno::Test
      include USQualityCoreTestKit::MustSupportTest

      title 'All must support elements are provided in the Specimen resources returned'

      description %(
        This test will look through the Specimen resources
        found previously for the following Must Support and USCDI-flagged elements:

        * Specimen.subject
        * Specimen.type
      )

      id :us_quality_core_v050_specimen_must_support_test

      def resource_type
        'Specimen'
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:specimen_resources] ||= {}
      end

      run do
        perform_must_support_test(all_scratch_resources)
      end
    end
  end
end
