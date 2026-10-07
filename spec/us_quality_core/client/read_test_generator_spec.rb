# frozen_string_literal: true

require 'us_quality_core_test_kit/client/generator/read_test_generator'
require 'us_quality_core_test_kit/generator/group_metadata'

RSpec.describe USQualityCoreTestKit::Client::Generator::ReadTestGenerator do
  [
    ['Patient', false, false],
    ['Practitioner', true, false],
    ['Observation', true, false],
    ['Observation', false, true],
    ['CarePlan', false, true],
    ['Encounter', false, false]
  ].each do |resource, delayed, optional|
    %w[SHALL MAY].each do |interaction_expectation|
      it "makes #{resource} reads #{optional ? 'optional' : 'mandatory'} when delayed=#{delayed} and interaction=#{interaction_expectation}" do
        group = USQualityCoreTestKit::Generator::GroupMetadata.new(
          resource:,
          name: resource,
          reformatted_version: 'v050',
          profile_name: resource,
          is_delayed: delayed,
          searches: delayed ? [] : [{ names: ['patient'], expectation: 'SHALL' }],
          interactions: [{ code: 'read', expectation: interaction_expectation }]
        )
        output = described_class.new(group, '/tmp').output

        expect(output).to include("optional #{optional}")
        expect(output).to include("title '#{interaction_expectation} support read of #{resource}'")
      end
    end
  end
end
