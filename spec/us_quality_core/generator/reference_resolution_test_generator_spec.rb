# frozen_string_literal: true

require 'tmpdir'
require 'us_quality_core_test_kit/generator'

RSpec.describe USQualityCoreTestKit::Generator::ReferenceResolutionTestGenerator do
  describe '.target_profile_versions' do
    let(:quality_core_base) { 'http://fhir.org/guides/onc/us-quality-core/' }
    let(:us_core_base) { 'http://hl7.org/fhir/us/core/' }

    def group(base, name, version)
      Struct.new(:profile_url, :profile_version).new("#{base}StructureDefinition/#{name}", version)
    end

    def ig_metadata(*groups)
      Struct.new(:groups).new(groups)
    end

    def generated_ig_metadata(ig_file_name)
      path = File.join(Dir.pwd, 'lib', 'us_quality_core_test_kit', 'igs', ig_file_name)
      generator = USQualityCoreTestKit::Generator.new(path)
      generator.load_ig_package
      generator.extract_metadata
    end

    it 'maps each canonical base to its version for v0.5.0' do
      versions = described_class.target_profile_versions(generated_ig_metadata('us.quality-core-0.5.0.tgz'))

      expect(versions).to eq(quality_core_base => '0.5.0', us_core_base => '6.1.0')
    end

    it 'maps each canonical base to its version for v1.0.0-ballot' do
      versions = described_class.target_profile_versions(generated_ig_metadata('us.quality-core-1.0.0-ballot.tgz'))

      expect(versions).to eq('http://hl7.org/fhir/us/quality-core/' => '1.0.0-ballot', us_core_base => '9.0.0')
    end

    it 'writes the map to the version directory' do
      Dir.mktmpdir do |dir|
        metadata = ig_metadata(group(quality_core_base, 'us-quality-core-patient', '0.5.0'),
                               group(us_core_base, 'us-core-practitioner', '6.1.0'))

        described_class.generate_target_profile_versions(metadata, dir)

        expect(YAML.load_file(File.join(dir, 'target_profile_versions.yml')))
          .to eq(quality_core_base => '0.5.0', us_core_base => '6.1.0')
      end
    end

    it 'raises when a canonical base has more than one version' do
      metadata = ig_metadata(group(us_core_base, 'us-core-patient', '6.1.0'),
                             group(us_core_base, 'us-core-practitioner', '7.0.0'))

      expect { described_class.target_profile_versions(metadata) }
        .to raise_error(/Multiple profile versions for #{Regexp.escape(us_core_base)}: 6\.1\.0, 7\.0\.0/)
    end

    it 'raises when a version is blank' do
      metadata = ig_metadata(group(quality_core_base, 'us-quality-core-patient', '0.5.0'),
                             group(us_core_base, 'us-core-practitioner', nil))

      expect { described_class.target_profile_versions(metadata) }
        .to raise_error(/Profile version is blank for #{Regexp.escape(us_core_base)}/)
    end
  end
end
