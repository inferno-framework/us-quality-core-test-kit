require_relative '../../../must_support_test'

module USQualityCoreTestKit
  module USQualityCoreV010
    class PractitionerMustSupportTest < Inferno::Test
      include USQualityCoreTestKit::MustSupportTest

      title 'All must support elements are provided in the Practitioner resources returned'

      description %(
        This test will look through the Practitioner resources
        found previously for the following Must Support and USCDI-flagged elements:

        * Practitioner.address
        * Practitioner.address.city
        * Practitioner.address.country
        * Practitioner.address.line
        * Practitioner.address.postalCode
        * Practitioner.address.state
        * Practitioner.identifier
        * Practitioner.identifier.system
        * Practitioner.identifier.value
        * Practitioner.identifier:NPI
        * Practitioner.identifier:ein
        * Practitioner.name
        * Practitioner.name.family
        * Practitioner.telecom
        * Practitioner.telecom.system
        * Practitioner.telecom.value

        For ASTP USCDI+ Quality requirements, each Practitioner must support the following additional elements:

        * Practitioner.identifier:NPI.system
        * Practitioner.identifier:NPI.value
        * Practitioner.identifier:ein.system
        * Practitioner.identifier:ein.value
      )

      id :us_quality_core_v010_practitioner_must_support_test

      def resource_type
        'Practitioner'
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:practitioner_resources] ||= {}
      end

      run do
        perform_must_support_test(all_scratch_resources)
      end
    end
  end
end
