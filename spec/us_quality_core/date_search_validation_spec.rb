# frozen_string_literal: true

require 'us_quality_core_test_kit/date_search_validation'

RSpec.describe USQualityCoreTestKit::DateSearchValidation do
  subject(:validator) { Class.new { include USQualityCoreTestKit::DateSearchValidation }.new }

  it 'validates a ge search against a dateTime target' do
    expect(validator.validate_date_search('ge2017-01-29', '2017-01-29T12:34:56+00:00')).to be true
  end

  it 'validates a le search against a dateTime target' do
    expect(validator.validate_date_search('le2017-01-29', '2017-01-29T12:34:56+00:00')).to be true
  end

  it 'validates comparator searches against Period targets' do
    period = FHIR::Period.new(start: '2017-01-29T12:34:56+00:00', end: '2017-01-30T12:34:56+00:00')

    expect(validator.validate_date_search('ge2017-01-29', period)).to be true
    expect(validator.validate_date_search('le2017-01-30', period)).to be true
  end
end
