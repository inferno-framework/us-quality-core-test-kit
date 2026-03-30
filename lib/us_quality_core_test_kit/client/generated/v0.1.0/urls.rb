# frozen_string_literal: true

module USQualityCoreTestKit
  module Client
    module USQualityCoreClientV010
      RESUME_PASS_ROUTE = '/resume_pass'
      FHIR_ROUTE = '/fhir'
      READ_ROUTE = "#{FHIR_ROUTE}/:resource_type/:resource_id"
      SEARCH_ROUTE = "#{FHIR_ROUTE}/:resource_type"
      SEARCH_POST_ROUTE = "#{FHIR_ROUTE}/:resource_type/_search"
      METADATA_PATH = "#{FHIR_ROUTE}/metadata"
      TOKEN_PATH = '/auth/token'.freeze
      AUTHORIZATION_PATH = '/auth/authorization'.freeze

      module URLs
        def base_url
          "#{Inferno::Application['base_url']}/custom/#{suite_id}"
        end

        def resume_pass_url
          base_url + RESUME_PASS_ROUTE
        end

        def fhir_url
          base_url + FHIR_ROUTE
        end

        def read_url
          base_url + READ_ROUTE
        end

        def search_url
          base_url + SEARCH_ROUTE
        end

        def suite_id
          'us_quality_core_client_v010'
        end
      end
    end
  end
end
