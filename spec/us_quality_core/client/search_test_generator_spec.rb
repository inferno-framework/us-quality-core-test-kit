# frozen_string_literal: true

require 'us_quality_core_test_kit/client/generator/search_test_generator'

RSpec.describe USQualityCoreTestKit::Client::Generator::SearchTestGenerator do
  let(:group_class) { Struct.new(:resource, :reformatted_version, :searches) }
  let(:required_search) do
    {
      names: %w[patient category],
      expectation: 'SHALL',
      must_support_or_mandatory: true
    }
  end
  let(:group) do
    group_class.new(
      'CarePlan',
      'v050',
      [required_search, { names: ['date'], expectation: 'SHALL', must_support_or_mandatory: true }]
    )
  end

  it 'adds deduplicated non-required parameter warnings to required search tests' do
    output = described_class.new(group, required_search, '/tmp').output

    expect(output).to include('non_required_search_parameters(requests_with_params, all_required_search_parameters)')
    expect(output).to include('["patient", "category", "date"]')
  end

  it 'does not add warnings to optional search tests' do
    optional_search = {
      names: %w[patient category],
      expectation: 'SHALL',
      must_support_or_mandatory: false
    }
    output = described_class.new(group, optional_search, '/tmp').output

    expect(output).not_to include('non_required_search_parameters')
  end
end
