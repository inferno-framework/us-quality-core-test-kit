# frozen_string_literal: true

require 'fileutils'
require 'json'
require 'tmpdir'
require 'zlib'
require 'rubygems/package'

require 'us_quality_core_test_kit/generator/ig_loader'

RSpec.describe USQualityCoreTestKit::Generator::IGLoader do
  def value_set_url(id)
    "http://example.com/fhir/ValueSet/#{id}"
  end

  def value_set_json(id)
    JSON.generate(
      resourceType: 'ValueSet',
      id: id,
      url: value_set_url(id),
      name: id.tr('-', '_'),
      status: 'active'
    )
  end

  def write_tgz(file_path, resources)
    File.open(file_path, 'wb') do |file|
      Zlib::GzipWriter.wrap(file) do |gzip|
        Gem::Package::TarWriter.new(gzip) do |tar|
          resources.each do |file_name, contents|
            tar.add_file_simple("package/#{file_name}", 0o644, contents.bytesize) do |entry|
              entry.write(contents)
            end
          end
        end
      end
    end
  end

  it 'loads standalone FHIR resources from package tgz files' do
    Dir.mktmpdir do |directory|
      ig_file_name = File.join(directory, 'us_quality_core_v010.tgz')
      ig_directory = ig_file_name.chomp('.tgz')

      FileUtils.mkdir_p(ig_directory)
      File.write(File.join(ig_directory, 'ValueSet-standalone-json.json'), value_set_json('standalone-json'))
      write_tgz(
        File.join(ig_directory, 'us_core_610.tgz'),
        'ValueSet-standalone-tgz.json' => value_set_json('standalone-tgz')
      )

      resources = described_class.new(ig_file_name).load_standalone_resources

      expect(resources.value_set_by_url(value_set_url('standalone-json'))).not_to be_nil
      expect(resources.value_set_by_url(value_set_url('standalone-tgz'))).not_to be_nil
    end
  end
end
