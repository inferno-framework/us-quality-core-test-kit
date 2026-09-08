# frozen_string_literal: true

require 'us_quality_core_test_kit/generator/search_test_generator'
require 'us_quality_core_test_kit/generator/provenance_revinclude_search_test_generator'

RSpec.describe USQualityCoreTestKit::Generator::SearchTestGenerator do
  let(:group_class) do
    Class.new(Struct.new(:resource, :version, :reformatted_version, :searches, :search_definitions, :delayed_references)) do
      def delayed?
        false
      end
    end
  end
  let(:search) do
    {
      names: %w[patient category],
      expectation: 'SHALL',
      must_support_or_mandatory: true
    }
  end
  let(:search_definitions) do
    {
      patient: { path: 'subject', comparators: {}, type: 'Reference', multiple_or: 'MAY' },
      category: { path: 'category', comparators: {}, type: 'CodeableConcept', multiple_or: 'MAY' }
    }
  end

  it 'uses a CarePlan category code input for the v1.0.0-ballot CarePlan search' do
    group = group_class.new('CarePlan', 'v1.0.0-ballot', 'v100_ballot', [search], search_definitions, [])

    output = described_class.new(group, search, '/tmp').output

    expect(output).to include('input :care_plan_category_code')
    expect(output).to include('[care_plan_category_code]')
  end

  it 'does not add the CarePlan category code input to other suites' do
    group = group_class.new('CarePlan', 'v0.5.0', 'v050', [search], search_definitions, [])

    output = described_class.new(group, search, '/tmp').output

    expect(output).not_to include('input :care_plan_category_code')
  end

  it 'uses the CarePlan category code input for the v1.0.0-ballot Provenance revinclude search' do
    group = group_class.new('CarePlan', 'v1.0.0-ballot', 'v100_ballot', [search], search_definitions, [])

    output = USQualityCoreTestKit::Generator::ProvenanceRevincludeSearchTestGenerator.new(group, search, '/tmp').output

    expect(output).to include('input :care_plan_category_code')
    expect(output).to include('[care_plan_category_code]')
  end
end
