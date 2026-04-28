require_relative '../../../must_support_test'

module USQualityCoreTestKit
  module USQualityCoreV010
    class ImmunizationMustSupportTest < Inferno::Test
      include USQualityCoreTestKit::MustSupportTest

      title 'All must support elements are provided in the Immunization resources returned'

      description %(
        This test will look through the Immunization resources
        found previously for the following Must Support and USCDI-flagged elements:

        * Immunization.encounter
        * Immunization.location
        * Immunization.occurrenceDateTime
        * Immunization.patient
        * Immunization.primarySource
        * Immunization.status
        * Immunization.statusReason
        * Immunization.vaccineCode
      )

      id :us_quality_core_v010_immunization_must_support_test

      def resource_type
        'Immunization'
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:immunization_resources] ||= {}
      end

      run do
        perform_must_support_test(all_scratch_resources)
      end
    end
  end
end
