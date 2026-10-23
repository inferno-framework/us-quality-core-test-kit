# frozen_string_literal: true

require 'tmpdir'
require 'us_quality_core_test_kit/client/generator/example_client_generator'
require 'us_quality_core_test_kit/generator/group_metadata'

RSpec.describe USQualityCoreTestKit::Client::Generator::ExampleClientGenerator do
  let(:group) do
    USQualityCoreTestKit::Generator::GroupMetadata.new(
      resource: 'Observation',
      name: 'us_quality_core_observation_clinical_result',
      title: 'Clinical Result',
      searches: [{ names: %w[_id patient code date] }],
      search_definitions: { code: { type: 'CodeableConcept' }, date: { type: 'dateTime' } }
    )
  end
  let(:metadata) { Struct.new(:ordered_groups, :reformatted_version).new([group], 'v100_ballot') }

  it 'generates a collection without a patient bundle or Patient group' do
    Dir.mktmpdir do |directory|
      Dir.chdir(directory) do
        generator = described_class.new(metadata, directory)
        generator.generate
        collection = JSON.parse(File.read(generator.output_file_name))
        requests = collection.fetch('item').first.fetch('item').map { |item| item.fetch('request').fetch('url') }

        expect(requests).to include(
          '{{base_url}}/Observation/usqualitycore-observation-clinical-result',
          '{{base_url}}/Observation/usqualitycore-observation-lab'
        )
        query = URI.decode_www_form(requests.last.split('?', 2).last).to_h
        expect(query).to eq(
          '_id' => 'usqualitycore-observation-clinical-result',
          'patient' => 'usqualitycore-patient',
          'code' => 'dummy',
          'date' => '2000-01-01'
        )
      end
    end
  end

  it 'uses metadata values and typed placeholders for example searches' do
    group.search_definitions = {
      status: { type: 'code', values: ['final'] },
      active: { type: 'boolean' },
      value: { type: 'Quantity' },
      definition: { type: 'canonical' }
    }
    builder = USQualityCoreTestKit::Client::Generator::ExampleSearchParameterBuilder.new
    values = %w[status active value definition subject].to_h do |name|
      [name, builder.search_param_value(name, group, 'usqualitycore-patient', 'observation_clinical_result')]
    end

    expect(values).to eq(
      'status' => 'final',
      'active' => 'true',
      'value' => '1',
      'definition' => 'http://example.org/example',
      'subject' => 'usqualitycore-patient'
    )
  end
end
