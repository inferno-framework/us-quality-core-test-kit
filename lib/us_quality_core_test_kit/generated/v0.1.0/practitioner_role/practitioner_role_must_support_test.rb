require_relative '../../../must_support_test'

module USQualityCoreTestKit
  module USQualityCoreV010
    class PractitionerRoleMustSupportTest < Inferno::Test
      include USQualityCoreTestKit::MustSupportTest

      title 'All must support elements are provided in the PractitionerRole resources returned'

      description %(
        This test will look through the PractitionerRole resources
        found previously for the following Must Support and USCDI-flagged elements:

        * PractitionerRole.code
        * PractitionerRole.endpoint
        * PractitionerRole.location
        * PractitionerRole.organization
        * PractitionerRole.practitioner
        * PractitionerRole.specialty
        * PractitionerRole.telecom
        * PractitionerRole.telecom.system
        * PractitionerRole.telecom.value

        For ASTP USCDI+ Quality requirements, each PractitionerRole must support the following additional elements:

        * PractitionerRole.identifier
        * PractitionerRole.identifier.system
        * PractitionerRole.identifier.value
      )

      id :us_quality_core_v010_practitioner_role_must_support_test

      def resource_type
        'PractitionerRole'
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:practitioner_role_resources] ||= {}
      end

      run do
        perform_must_support_test(all_scratch_resources)
      end
    end
  end
end
