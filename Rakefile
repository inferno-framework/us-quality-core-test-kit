# frozen_string_literal: true

require 'pry'
require 'pry-byebug'
require 'fileutils'

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

generate_us_quality_core = lambda do
  supported_modes = %w[server client].freeze
  mode = ENV['mode'].to_s.strip
  clean = ENV['clean'].to_s.strip

  abort "Unsupported generation mode: #{mode}. Use mode=server, mode=client, or no mode for both." unless mode.empty? || supported_modes.include?(mode)
  abort "Unsupported clean value: #{clean}. Use clean=true or omit clean." unless clean.empty? || clean == 'true'

  targets = mode.empty? ? supported_modes : [mode]

  if clean == 'true'
    FileUtils.rm_rf('lib/us_quality_core_test_kit/generated')
    FileUtils.rm_rf('lib/us_quality_core_test_kit/client/generated')
  end

  require_relative 'lib/us_quality_core_test_kit/generator'
  require_relative 'lib/us_quality_core_test_kit/client/generator'

  USQualityCoreTestKit::Generator.generate if targets.include?('server')

  USQualityCoreTestKit::Client::Generator.generate if targets.include?('client')
end

namespace :us_quality_core do
  desc 'Generate tests (mode=server or mode=client; clean=true removes generated files first; defaults to both)'
  task :generate do
    generate_us_quality_core.call
  end
end

# Alias
namespace :usqualitycore do
  desc 'Generate tests (mode=server or mode=client; clean=true removes generated files first; defaults to both)'
  task :generate do
    generate_us_quality_core.call
  end
end
