# frozen_string_literal: true

RSpec.describe USQualityCoreTestKit::Client::USQualityCoreClientV050::ObservationLabClientReadTest do
  include_context 'when testing a runnable'

  let(:suite_id) { 'us_quality_core_client_v050' }
  let(:read_tag) { USQualityCoreTestKit::Client::USQualityCoreClientV050::READ_OBSERVATION_TAG }

  it 'passes for a read with an arbitrary resource ID' do
    request = Struct.new(:url).new('http://example.com/Observation/arbitrary-id')
    allow_any_instance_of(described_class).to receive(:load_tagged_requests).with(read_tag).and_return([request])

    expect(run(described_class).result).to eq('pass')
  end

  it 'does not pass without a read of the expected resource type' do
    allow_any_instance_of(described_class).to receive(:load_tagged_requests).with(read_tag).and_return([])

    expect(run(described_class).result).to eq('skip')
  end
end
