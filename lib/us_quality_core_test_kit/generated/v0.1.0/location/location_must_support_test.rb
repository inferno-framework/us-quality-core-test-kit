require_relative '../../../must_support_test'

module USQualityCoreTestKit
  module USQualityCoreV010
    class LocationMustSupportTest < Inferno::Test
      include USQualityCoreTestKit::MustSupportTest

      title 'All must support elements are provided in the Location resources returned'

      description %(
        This test will look through the Location resources
        found previously for the following Must Support and USCDI-flagged elements:

        * Location.address
        * Location.address.city
        * Location.address.line
        * Location.address.postalCode
        * Location.address.state
        * Location.managingOrganization
        * Location.name
        * Location.status
        * Location.telecom

        For ONC USCDI+ Quality requirements, each Location must support the following additional elements:

        * Location.type
      )

      id :us_quality_core_v010_location_must_support_test

      def resource_type
        'Location'
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:location_resources] ||= {}
      end

      run do
        perform_must_support_test(all_scratch_resources)
      end
    end
  end
end
