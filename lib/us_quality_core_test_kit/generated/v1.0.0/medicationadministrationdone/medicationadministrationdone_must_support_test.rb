require_relative '../../../must_support_test'

module USQualityCoreTestKit
  module USQualityCoreV100
    class MedicationadministrationdoneMustSupportTest < Inferno::Test
      include USQualityCoreTestKit::MustSupportTest

      title 'All must support elements are provided in the MedicationAdministration resources returned'

      description %(
        This test will look through the MedicationAdministration resources
        found previously for the following Must Support and USCDI-flagged elements:


      )

      id :us_quality_core_v100_medicationadministrationdone_must_support_test

      def resource_type
        'MedicationAdministration'
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:medicationadministrationdone_resources] ||= {}
      end

      run do
        perform_must_support_test(all_scratch_resources)
      end
    end
  end
end
