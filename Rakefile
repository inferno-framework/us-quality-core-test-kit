# frozen_string_literal: true

require 'pry'
require 'pry-byebug'

begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec)
  task default: :spec
rescue LoadError # rubocop:disable Lint/SuppressedException
end

namespace :db do
  desc 'Apply changes to the database'
  task :migrate do
    require 'inferno/config/application'
    require 'inferno/utils/migration'
    Inferno::Utils::Migration.new.run
  end
end

generate_us_quality_core = lambda do |args|
  supported_targets = %w[server client].freeze
  targets = [args[:server], args[:client], *args.extras]
            .compact
            .flat_map { |target| target.to_s.split(',') }
            .map(&:strip)
            .reject(&:empty?)

  targets = supported_targets if targets.empty?

  unsupported_targets = targets - supported_targets
  unless unsupported_targets.empty?
    abort "Unsupported generation target(s): #{unsupported_targets.join(', ')}. Use server, client, or no arguments for both."
  end

  if targets.include?('server')
    require_relative 'lib/us_quality_core_test_kit/generator'
    USQualityCoreTestKit::Generator.generate
  end

  if targets.include?('client')
    require_relative 'lib/us_quality_core_test_kit/client/generator'
    USQualityCoreTestKit::Client::Generator.generate
  end
end

namespace :us_quality_core do
  desc 'Generate tests (targets: server, client; defaults to both)'
  task :generate, %i[server client] do |_task, args|
    generate_us_quality_core.call(args)
  end
end

# Alias
namespace :usqualitycore do
  desc 'Generate tests (targets: server, client; defaults to both)'
  task :generate, %i[server client] do |_task, args|
    generate_us_quality_core.call(args)
  end
end
