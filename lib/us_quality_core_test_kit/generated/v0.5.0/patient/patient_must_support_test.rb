require_relative '../../../must_support_test'

module USQualityCoreTestKit
  module USQualityCoreV050
    class PatientMustSupportTest < Inferno::Test
      include USQualityCoreTestKit::MustSupportTest

      title 'All must support elements are provided in the Patient resources returned'

      description %(
        This test will look through the Patient resources
        found previously for the following Must Support and USCDI-flagged elements:

        * Patient.address
        * Patient.address.city
        * Patient.address.line
        * Patient.address.postalCode
        * Patient.address.state
        * Patient.birthDate
        * Patient.extension:sex
        * Patient.gender
        * Patient.identifier
        * Patient.identifier.system
        * Patient.identifier.value
        * Patient.name
        * Patient.name.family
        * Patient.name.given

        For ONC USCDI+ Quality requirements, each Patient must support the following additional elements:

        * Patient.address.period.end or Patient.address.use
        * Patient.communication
        * Patient.communication.language
        * Patient.deceased[x]
        * Patient.extension:ethnicity
        * Patient.extension:race
        * Patient.extension:tribalAffiliation
        * Patient.name.period.end or Patient.name.use
        * Patient.name.suffix
        * Patient.telecom
        * Patient.telecom.system
        * Patient.telecom.use
        * Patient.telecom.value
      )

      id :us_quality_core_v050_patient_must_support_test

      def resource_type
        'Patient'
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:patient_resources] ||= {}
      end

      run do
        perform_must_support_test(all_scratch_resources)
      end
    end
  end
end
