# frozen_string_literal: true

require 'active_support/all'
require 'fhir_models'
require 'pathname'
require 'rubygems/package'
require 'zlib'
require_relative 'ig_resources'

module USQualityCoreTestKit
  class Generator
    class IGLoader
      attr_accessor :ig_file_name


      def initialize(ig_file_name)
        self.ig_file_name = ig_file_name
      end

      def load
        load_ig
        load_standalone_resources
      end

      def load_ig
        tar = Gem::Package::TarReader.new(
          Zlib::GzipReader.open(ig_file_name)
        )

        tar.each do |entry|
          next if entry.directory?

          file_name = entry.full_name.split('/').last

          next if file_name.end_with? 'openapi.json'

          next unless file_name.end_with? '.json'

          next unless entry.full_name.start_with? 'package/'

          begin
            resource = FHIR.from_contents(entry.read)
            next if resource.nil?
          rescue StandardError
            puts "#{file_name} does not appear to be a FHIR resource."
            next
          end

          ig_resources.add(resource)
        end

        ig_resources
      end

      def ig_resources
        @ig_resources ||= IGResources.new
      end

      def load_standalone_resources
        ig_directory = ig_file_name.chomp('.tgz')

        return ig_resources unless File.exist? ig_directory

        Dir.glob(File.join(ig_directory, '*.{json,tgz}')).each do |file_path|
          if file_path.end_with? '.tgz'
            load_tgz_resources(file_path)
          else
            load_json_resource(file_path)
          end
        end

        ig_resources
      end

      private

      def load_tgz_resources(file_path)
        tar = Gem::Package::TarReader.new(
          Zlib::GzipReader.open(file_path)
        )

        tar.each do |entry|
          next if entry.directory?

          file_name = entry.full_name.split('/').last

          next if file_name.end_with? 'openapi.json'

          next if file_name.start_with? 'CapabilityStatement'

          next unless file_name.end_with? '.json'

          next unless entry.full_name.start_with? 'package/'

          load_resource(entry.read, file_name)
        end
      end

      def load_json_resource(file_path)
        load_resource(File.read(file_path), file_path.split('/').last)
      end

      def load_resource(contents, file_name)
        begin
          resource = FHIR.from_contents(contents)
          return if resource.nil?
        rescue StandardError
          puts "#{file_name} does not appear to be a FHIR resource."
          return
        end

        ig_resources.add(resource)
      end
    end
  end
end
