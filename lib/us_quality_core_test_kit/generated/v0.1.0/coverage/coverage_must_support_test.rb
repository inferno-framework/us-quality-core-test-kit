require_relative '../../../must_support_test'

module USQualityCoreTestKit
  module USQualityCoreV010
    class CoverageMustSupportTest < Inferno::Test
      include USQualityCoreTestKit::MustSupportTest

      title 'All must support elements are provided in the Coverage resources returned'

      description %(
        This test will look through the Coverage resources
        found previously for the following Must Support and USCDI-flagged elements:

        * Coverage.beneficiary
        * Coverage.class
        * Coverage.class:group
        * Coverage.class:group.name
        * Coverage.class:group.value
        * Coverage.class:plan
        * Coverage.class:plan.name
        * Coverage.class:plan.value
        * Coverage.identifier
        * Coverage.identifier:memberid
        * Coverage.identifier:memberid.type
        * Coverage.payor
        * Coverage.period
        * Coverage.relationship
        * Coverage.status
        * Coverage.subscriberId
        * Coverage.type
      )

      id :us_quality_core_v010_coverage_must_support_test

      def resource_type
        'Coverage'
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:coverage_resources] ||= {}
      end

      run do
        perform_must_support_test(all_scratch_resources)
      end
    end
  end
end
