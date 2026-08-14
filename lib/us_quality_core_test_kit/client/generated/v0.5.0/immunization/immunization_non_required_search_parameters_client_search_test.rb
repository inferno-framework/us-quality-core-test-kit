# frozen_string_literal: true

module USQualityCoreTestKit
  module Client
    module USQualityCoreClientV050
      class ImmunizationNonRequiredSearchParametersClientSearchTest < Inferno::Test
        include TestHelper

        id :us_quality_core_v050_immunization_non_required_search_parameters_client_search_test

        title 'SHOULD only use required search parameters for Immunization'

        description %(
          This test warns when the client uses search parameters that are not required by the US Quality Core IG CapabilityStatement.
        )

        optional true

        def required_search_parameters
          ["patient", "status"]
        end

        run do
          requests = load_tagged_requests(SEARCH_IMMUNIZATION_TAG)
          skip_if requests.blank?, "Inferno did not receive any search requests for the `Immunization` resource type."

          non_required_search_parameters(requests, required_search_parameters).each do |parameter|
            warning "The client used the non-required search parameter `#{parameter}` for `Immunization`. " \
                    'The server may not accept search parameters other than those required by the IG CapabilityStatement.'
          end
        end
      end
    end
  end
end
