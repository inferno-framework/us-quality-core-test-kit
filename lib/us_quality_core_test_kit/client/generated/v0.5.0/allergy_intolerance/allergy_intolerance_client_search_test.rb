# frozen_string_literal: true

# Only SHALL client searches are generated. SHOULD search tests may be added later.
module USQualityCoreTestKit
  module Client
    module USQualityCoreClientV050
      class AllergyIntoleranceClientSearchTest < Inferno::Test
        include TestHelper

        id :us_quality_core_v050_allergy_intolerance_client_search_test

        title 'Search AllergyIntolerance using a supported combination'

        description %(
          The client demonstrates at least one required server search combination for AllergyIntolerance.
          Accepted combinations: `patient`.
        )

        def required_search_combinations
          [["patient"]]
        end

        def skip_message
          'Inferno did not receive any search requests for the `AllergyIntolerance` resource type.'
        end

        def failure_message
          'Inferno did not receive a search for `AllergyIntolerance` using any of these combinations: ' \
          "#{required_search_combinations.map { |names| names.join(' + ') }.join(', ')}."
        end        

        def all_required_search_parameters
          ["patient"]
        end

        run do
          requests = load_tagged_requests(SEARCH_ALLERGY_INTOLERANCE_TAG)
          skip_if requests.blank?, skip_message

          matching_requests = filter_requests_by_search_parameter_combinations(requests, required_search_combinations)
          assert matching_requests.any?, failure_message

          non_required_search_parameters(matching_requests, all_required_search_parameters).each do |parameter|
            warning "The client used the non-required search parameter `#{parameter}` for `AllergyIntolerance`. " \
                    'The server may not accept search parameters other than those required by the IG CapabilityStatement.'
          end
        end
      end
    end
  end
end
