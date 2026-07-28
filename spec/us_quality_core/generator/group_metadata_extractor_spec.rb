# frozen_string_literal: true

require 'us_quality_core_test_kit/generator/group_metadata_extractor'

RSpec.describe USQualityCoreTestKit::Generator::GroupMetadataExtractor do
  describe '#mark_mandatory_and_must_support_searches' do
    let(:search) { { names: ['do-not-perform'] } }
    let(:extractor) { described_class.allocate }

    before do
      allow(extractor).to receive(:resource).and_return('DeviceRequest')
      allow(extractor).to receive(:searches).and_return([search])
      allow(extractor).to receive(:search_definitions).and_return(
        {
          'do-not-perform': {
            full_paths: [
              "DeviceRequest.modifierExtension.where(url='http://hl7.org/fhir/5.0/StructureDefinition/extension-DeviceRequest.doNotPerform').value"
            ]
          }
        }
      )
      allow(extractor).to receive(:must_supports).and_return(elements: [], slices: [])
      allow(extractor).to receive(:mandatory_elements).and_return(
        %w[DeviceRequest.modifierExtension.url DeviceRequest.modifierExtension.value[x]]
      )
    end

    it 'recognizes a search on a mandatory modifier extension' do
      extractor.send(:mark_mandatory_and_must_support_searches)

      expect(search[:names_not_must_support_or_mandatory]).to be_empty
      expect(search[:must_support_or_mandatory]).to be(true)
    end

    it 'recognizes a typed search path for a mandatory choice element' do
      code_search = { names: ['code'] }
      allow(extractor).to receive(:searches).and_return([code_search])
      allow(extractor).to receive(:search_definitions).and_return(
        { code: { full_paths: ['MedicationAdministration.medicationCodeableConcept'] } }
      )
      allow(extractor).to receive(:mandatory_elements).and_return(['MedicationAdministration.medication[x]'])

      extractor.send(:mark_mandatory_and_must_support_searches)

      expect(code_search[:names_not_must_support_or_mandatory]).to be_empty
      expect(code_search[:must_support_or_mandatory]).to be(true)
    end

    it 'excludes the ServiceRequest do-not-perform search parameter' do
      allow(extractor).to receive(:resource).and_return('ServiceRequest')

      extractor.send(:mark_mandatory_and_must_support_searches)

      expect(search[:names_not_must_support_or_mandatory]).to be_empty
      expect(search[:must_support_or_mandatory]).to be(true)
    end
  end
end
