require_relative '../../../must_support_test'

module USQualityCoreTestKit
  module USQualityCoreV100_BALLOT
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
        * Patient.communication.language
        * Patient.identifier
        * Patient.identifier.system
        * Patient.identifier.value
        * Patient.name
        * Patient.name.family
        * Patient.name.given
        * Patient.telecom.system
        * Patient.telecom.use
        * Patient.telecom.value

        For ONC USCDI+ Quality requirements, each Patient must support the following additional elements:

        * Patient.address.period
        * Patient.address.period.end or Patient.address.use
        * Patient.communication
        * Patient.deceased[x]
        * Patient.extension:ethnicity
        * Patient.extension:interpreterRequired
        * Patient.extension:race
        * Patient.extension:sex
        * Patient.extension:tribalAffiliation
        * Patient.name.period
        * Patient.name.period.end or Patient.name.use
        * Patient.name.suffix
        * Patient.telecom
      )

      id :us_quality_core_v100_ballot_patient_must_support_test

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
