require_relative '../../../must_support_test'

module USQualityCoreTestKit
  module USQualityCoreV010
    class OrganizationMustSupportTest < Inferno::Test
      include USQualityCoreTestKit::MustSupportTest

      title 'All must support elements are provided in the Organization resources returned'

      description %(
        This test will look through the Organization resources
        found previously for the following Must Support and USCDI-flagged elements:

        * Organization.active
        * Organization.address
        * Organization.address.city
        * Organization.address.country
        * Organization.address.line
        * Organization.address.postalCode
        * Organization.address.state
        * Organization.identifier
        * Organization.identifier:NPI
        * Organization.identifier:ccn
        * Organization.identifier:ein
        * Organization.name
        * Organization.telecom
        * Organization.telecom.system
        * Organization.telecom.value
      )

      id :us_quality_core_v010_organization_must_support_test

      def resource_type
        'Organization'
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:organization_resources] ||= {}
      end

      run do
        perform_must_support_test(all_scratch_resources)
      end
    end
  end
end
