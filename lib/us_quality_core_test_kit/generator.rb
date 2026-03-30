# frozen_string_literal: true

require_relative 'generator/ig_loader'
require_relative 'generator/ig_metadata_extractor'
require_relative 'generator/search_test_generator'
require_relative 'generator/read_test_generator'
require_relative 'generator/validation_test_generator'
require_relative 'generator/must_support_test_generator'
require_relative 'generator/reference_resolution_test_generator'
require_relative 'generator/group_generator'
require_relative 'generator/suite_generator'

module USQualityCoreTestKit
  class Generator
    def self.generate
      ig_packages = Dir.glob(File.join(Dir.pwd, 'lib', 'us_quality_core_test_kit', 'igs', '*.tgz'))

      ig_packages.each do |ig_package|
        new(ig_package).generate
      end
    end

    attr_accessor :ig_resources, :ig_metadata, :ig_file_name

    def initialize(ig_file_name)
      self.ig_file_name = ig_file_name
    end

    def generate
      puts "Generating server suite for #{File.basename(ig_file_name)}..."

      # Extraction
      load_ig_package
      extract_metadata

      # Generation
      FileUtils.mkdir_p(base_output_dir)
      generate_search_tests
      generate_read_tests
      generate_validation_tests
      generate_must_support_tests
      generate_reference_resolution_tests
      generate_groups
      generate_suites

      write_metadata

      puts 'done.'
    end

    def base_output_dir
      File.join(__dir__, 'generated', ig_metadata.ig_version)
    end

    def load_ig_package
      FHIR.logger = Logger.new(File::NULL)
      self.ig_resources = IGLoader.new(ig_file_name).load
    end

    def extract_metadata
      self.ig_metadata = IGMetadataExtractor.new(ig_resources).extract
    end

    def generate_search_tests
      SearchTestGenerator.generate(ig_metadata, base_output_dir)
    end

    def generate_read_tests
      ReadTestGenerator.generate(ig_metadata, base_output_dir)
    end

    def generate_validation_tests
      ValidationTestGenerator.generate(ig_metadata, base_output_dir)
    end

    def generate_must_support_tests
      MustSupportTestGenerator.generate(ig_metadata, base_output_dir)
    end

    def generate_reference_resolution_tests
      ReferenceResolutionTestGenerator.generate(ig_metadata, base_output_dir)
    end

    def generate_groups
      GroupGenerator.generate(ig_metadata, base_output_dir)
    end

    def generate_suites
      SuiteGenerator.generate(ig_metadata, base_output_dir)
    end

    def write_metadata
      File.write(File.join(base_output_dir, 'metadata.yml'), YAML.dump(ig_metadata.to_hash))
    end
  end
end
