# frozen_string_literal: true

require 'us_quality_core_test_kit/reference_resolution_test'

RSpec.describe USQualityCoreTestKit::ReferenceResolutionTest do
  let(:resource) { FHIR::Practitioner.new(id: '123') }

  def validated_profile(test_class, target_profile)
    test = test_class.new(scratch: {})
    profile_url = nil
    allow(test).to receive(:resource_is_valid?) do |**args|
      profile_url = args[:profile_url]
      true
    end

    expect(test.resource_is_valid_with_target_profile?(resource, target_profile)).to be(true)
    profile_url
  end

  context 'with a v0.5.0 test' do
    let(:test_class) { USQualityCoreTestKit::USQualityCoreV050::MedicationdispenseReferenceResolutionTest }

    it 'uses the US Core version US Quality Core 0.5.0 depends on for US Core target profiles' do
      # The v0.5.0 validator session also loads US Core 7.0.0 (through hl7.fhir.us.cql)
      expect(validated_profile(test_class, 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-practitioner'))
        .to eq('http://hl7.org/fhir/us/core/StructureDefinition/us-core-practitioner|6.1.0')
    end

    it 'uses the US Quality Core version for US Quality Core target profiles' do
      profile = 'http://fhir.org/guides/onc/us-quality-core/StructureDefinition/us-quality-core-patient'

      expect(validated_profile(test_class, profile)).to eq("#{profile}|0.5.0")
    end

    it 'leaves target profiles from other IGs unversioned' do
      profile = 'http://hl7.org/fhir/StructureDefinition/Practitioner'

      expect(validated_profile(test_class, profile)).to eq(profile)
    end

    it 'leaves versioned target profiles unchanged' do
      profile = 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-practitioner|7.0.0'

      expect(validated_profile(test_class, profile)).to eq(profile)
    end
  end

  context 'with a v1.0.0-ballot test' do
    let(:test_class) { USQualityCoreTestKit::USQualityCoreV100_BALLOT::DevicerequestReferenceResolutionTest }

    it 'uses US Core 9.0.0 for US Core target profiles' do
      expect(validated_profile(test_class, 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-patient'))
        .to eq('http://hl7.org/fhir/us/core/StructureDefinition/us-core-patient|9.0.0')
    end
  end

  context 'with a test class that has no metadata' do
    let(:test_class) do
      Class.new(Inferno::Test) do
        include USQualityCoreTestKit::ReferenceResolutionTest
      end
    end

    it 'leaves target profiles unchanged' do
      profile = 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-practitioner'

      expect(validated_profile(test_class, profile)).to eq(profile)
    end
  end

  context 'with a version that has no target profile versions' do
    let(:test_class) do
      Class.new(Inferno::Test) do
        include USQualityCoreTestKit::ReferenceResolutionTest

        def self.metadata
          USQualityCoreTestKit::Generator::GroupMetadata.new(version: 'v9.9.9')
        end
      end
    end

    it 'leaves target profiles unchanged' do
      profile = 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-practitioner'

      expect(validated_profile(test_class, profile)).to eq(profile)
    end
  end
end
