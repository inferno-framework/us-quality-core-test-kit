# frozen_string_literal: true

require_relative 'lib/us_quality_core_test_kit/version'

Gem::Specification.new do |spec|
  spec.name          = 'us_quality_core_test_kit'
  spec.version       = USQualityCoreTestKit::VERSION
  spec.summary       = 'US Quality Core Test Kit'
  spec.homepage      = 'https://github.com/inferno-framework/us-quality-core-test-kit'
  spec.license       = 'Apache-2.0'
  spec.authors       = ['MITRE']

  spec.add_dependency 'inferno_core', '~> 1.3', '>= 1.3.1'
  spec.add_dependency 'us_core_test_kit', '~> 1.1', '>= 1.1.3'

  spec.required_ruby_version = Gem::Requirement.new('>= 3.3.6')
  spec.metadata['inferno_test_kit'] = 'true'
  spec.metadata['rubygems_mfa_required'] = 'true'
  spec.metadata['source_code_uri'] = 'https://github.com/inferno-framework/us-quality-core-test-kit'
  spec.metadata['bug_tracker_uri'] = 'https://github.com/inferno-framework/us-quality-core-test-kit/issues'
  spec.metadata['changelog_uri'] = 'https://github.com/inferno-framework/us-quality-core-test-kit/releases'
  spec.files         = `[ -d .git ] && git ls-files -z lib config/presets LICENSE NOTICE.md README.md`.split("\x0")
  spec.require_paths = ['lib']
end
