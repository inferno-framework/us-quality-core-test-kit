# frozen_string_literal: true

RSpec.describe USQualityCoreTestKit::PractitionerAddressTest do
  let(:practitioner) { FHIR::Practitioner.new(id: '123') }
  let(:practitioner_role) { FHIR::PractitionerRole.new(id: '456') }
  let(:references) { [{ reference: FHIR::Reference.new(reference: 'Practitioner/123') }] }

  def validated_profile(test_class)
    test = test_class.new(scratch: { references: { 'Practitioner' => references } })
    profile_url = nil

    allow(test).to receive_messages(resolve_reference: practitioner, search_and_check_response: nil,
                                    fetch_all_bundled_resources: [practitioner_role])
    allow(test).to receive(:resource_is_valid_with_target_profile?) do |_resource, target_profile|
      profile_url = target_profile
      true
    end

    test.verify_practitioner_address
    profile_url
  end

  it 'validates the PractitionerRole against the v0.5.0 canonical and version' do
    test_class = USQualityCoreTestKit::USQualityCoreV050::PractitionerAddressTest

    expect(validated_profile(test_class))
      .to eq('http://fhir.org/guides/onc/us-quality-core/StructureDefinition/us-quality-core-practitionerrole|0.5.0')
  end

  it 'validates the PractitionerRole against the v1.0.0-ballot canonical and version' do
    test_class = USQualityCoreTestKit::USQualityCoreV100_BALLOT::PractitionerAddressTest

    expect(validated_profile(test_class))
      .to eq('http://hl7.org/fhir/us/quality-core/StructureDefinition/us-quality-core-practitionerrole|1.0.0-ballot')
  end
end
