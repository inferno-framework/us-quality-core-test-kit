# frozen_string_literal: true

require 'us_quality_core_test_kit/client/generator/search_test_generator'
require 'tmpdir'

RSpec.describe USQualityCoreTestKit::Client::Generator::SearchTestGenerator do
  let(:group_class) do
    Struct.new(:resource, :reformatted_version, :searches, :tests) do
      def add_test(test)
        self.tests ||= []
        tests << test
      end
    end
  end
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

  it 'accepts any SHALL combination and warns about parameters outside them' do
    output = described_class.new(group, required_search, '/tmp').output

    expect(output).to include('filter_requests_by_search_parameter_combinations(requests, required_search_combinations)')
    expect(output).to include('[["patient", "category"], ["date"]]')
    expect(output).to include('non_required_search_parameters(matching_requests, all_required_search_parameters)')
    expect(output).to include('["patient", "category", "date"]')
  end

  it 'generates one required test for all SHALL combinations' do
    ig_metadata = Struct.new(:groups).new([group])

    Dir.mktmpdir do |output_dir|
      described_class.generate(ig_metadata, output_dir)

      expect(group.tests.map { |test| test[:file_name] }).to eq(['care_plan_client_search_test.rb'])
      expect(File.read(File.join(output_dir, 'care_plan', 'care_plan_client_search_test.rb')))
        .to include('[["patient", "category"], ["date"]]')
    end
  end

  it 'does not generate SHOULD search tests' do
    group.searches << { names: ['status'], expectation: 'SHOULD' }
    ig_metadata = Struct.new(:groups).new([group])

    Dir.mktmpdir do |output_dir|
      described_class.generate(ig_metadata, output_dir)

      expect(group.tests.length).to eq(1)
      expect(File.read(File.join(output_dir, 'care_plan', 'care_plan_client_search_test.rb')))
        .not_to include('"status"')
    end
  end
end
