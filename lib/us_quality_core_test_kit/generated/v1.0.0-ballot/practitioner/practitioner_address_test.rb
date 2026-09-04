require_relative '../../../practitioner_address_test'

module USQualityCoreTestKit
  module USQualityCoreV100_BALLOT
    class PractitionerAddressTest < Inferno::Test
      include USQualityCoreTestKit::PractitionerAddressTest

      title 'Server support either Practitioner.address or PractitionerRole'
      description %(
        US Quality Core Responders SHALL support either US Quality Core PractitionerRole Profile or
        these data elements in US Quality Core Practitioner Profile

        * Practitioner.address
        * Practitioner.address.city
        * Practitioner.address.country
        * Practitioner.address.line
        * Practitioner.address.postalCode
        * Practitioner.address.state
      )

      id :us_quality_core_v100_ballot_practitioner_address_test

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      run do
        verify_practitioner_address
      end
    end
  end
end
