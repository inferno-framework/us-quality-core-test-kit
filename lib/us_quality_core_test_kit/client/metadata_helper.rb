# frozen_string_literal: true

require 'erb'

module USQualityCoreTestKit
  module Client
    module MetadataHelper
      module_function

      def get_metadata(version, metadata_path)
        proc {
          [200, { 'Content-Type' => 'application/fhir+json;charset=utf-8', 'Access-Control-Allow-Origin' => '*' },
           [capability_statement(metadata_path, version)]]
        }
      end

      def capability_statement(metadata_path, version)
        ERB.new(File.read(metadata_path), trim_mode: '-').result_with_hash(
          client_suite_base_url: client_suite_base_url(version)
        )
      end

      def client_suite_base_url(version)
        "#{Inferno::Application['base_url']}/custom/us_quality_core_client_#{version}"
      end
    end
  end
end
