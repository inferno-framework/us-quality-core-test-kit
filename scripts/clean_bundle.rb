#!/usr/bin/env ruby
# frozen_string_literal: true

#
# Script to help maintain the bundle of sample US Quality Core resources.
#

require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'

  gem 'activesupport'
end

require 'active_support/all'

path = ARGV[0]

bundle = JSON.parse(File.read(path))

bundle['entry'].each_with_index do |entry, index|
  rid = entry.dig('resource', 'id')
  rtype = entry.dig('resource', 'resourceType')

  # Add fullUrl
  unless entry.keys.include? 'fullUrl'
    url = "http://example.org/fhir/#{rtype}/#{rid}"
    entry['fullUrl'] = url
  end

  # Add text
  unless entry['resource'].keys.include? 'text'
    div = "<div xmlns=\"http://www.w3.org/1999/xhtml\">Generated Narrative: #{rid}</div>"
    entry['resource']['text'] = {
      status: 'generated',
      div: div
    }
  end

  # Sort entry keys
  bundle['entry'][index] = entry.sort.to_h
end

# Sort by resource id
bundle['entry'].sort_by! { |entry| entry['resource']['id'] }

File.write(path, JSON.pretty_generate(bundle))

puts 'done.'
