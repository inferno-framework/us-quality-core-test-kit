# frozen_string_literal: true

require_relative 'lib/us_quality_core_test_kit/version'

Gem::Specification.new do |spec|
  spec.name          = 'us_quality_core_test_kit'
  spec.version       = USQualityCoreTestKit::VERSION
  spec.summary       = 'US Quality Core Test Kit'
  spec.authors       = ['MITRE']

  spec.add_dependency 'inferno_core', '~> 1.0.6'
  spec.add_dependency 'us_core_test_kit', '~> 1.0.0'

  spec.required_ruby_version = Gem::Requirement.new('>= 3.3.6')
  spec.metadata['inferno_test_kit'] = 'true'
  spec.metadata['rubygems_mfa_required'] = 'true'
  spec.files         = `[ -d .git ] && git ls-files -z lib config/presets`.split("\x0")
  spec.require_paths = ['lib']
end
