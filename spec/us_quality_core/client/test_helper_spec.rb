# frozen_string_literal: true

require 'us_quality_core_test_kit/client/test_helper'

RSpec.describe USQualityCoreTestKit::Client::TestHelper do
  subject(:helper) do
    Class.new do
      include USQualityCoreTestKit::Client::TestHelper
    end.new
  end

  let(:request_class) { Struct.new(:verb, :url, :request_body) }

  it 'returns one additional parameter when it occurs in multiple requests' do
    requests = [
      request_class.new('GET', 'http://example.com/CarePlan?patient=1&category=plan&goal=1'),
      request_class.new('GET', 'http://example.com/CarePlan?patient=1&category=plan&goal=2')
    ]

    expect(helper.non_required_search_parameters(requests, %w[patient category])).to eq(['goal'])
  end

  it 'returns one additional parameter for each distinct parameter used' do
    requests = [
      request_class.new('GET', 'http://example.com/CarePlan?patient=1&category=plan&goal=1'),
      request_class.new('POST', 'http://example.com/CarePlan/_search', 'patient=1&category=plan&date=2026-01-01')
    ]

    expect(helper.non_required_search_parameters(requests, %w[patient category])).to contain_exactly('goal', 'date')
  end

  it 'does not return required parameters used in different required combinations' do
    requests = [request_class.new('GET', 'http://example.com/Observation?patient=1&category=laboratory&date=2026-01-01')]

    expect(helper.non_required_search_parameters(requests, %w[patient category date])).to be_empty
  end

  describe '#filter_requests_by_search_parameter_combinations' do
    let(:combinations) { [%w[subject], %w[subject event], %w[subject recorded-date]] }

    it 'accepts any listed combination in GET and POST requests' do
      requests = [
        request_class.new('GET', 'http://example.com/AdverseEvent?event=123'),
        request_class.new('GET', 'http://example.com/AdverseEvent?subject=Patient/1'),
        request_class.new('POST', 'http://example.com/AdverseEvent/_search', 'subject=Patient%2F1&event=123')
      ]

      expect(helper.filter_requests_by_search_parameter_combinations(requests, combinations)).to eq(requests.last(2))
    end

    it 'rejects requests that do not contain a complete combination' do
      requests = [request_class.new('GET', 'http://example.com/CarePlan?patient=1')]

      expect(helper.filter_requests_by_search_parameter_combinations(requests, [%w[patient category]])).to be_empty
    end
  end
end
