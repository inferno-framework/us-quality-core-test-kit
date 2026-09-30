# frozen_string_literal: true

# Only SHALL client searches are generated. SHOULD search tests may be added later.
module USQualityCoreTestKit
  module Client
    module USQualityCoreClientV100_BALLOT
      class CoverageClientSearchTest < Inferno::Test
        include TestHelper

        id :us_quality_core_v100_ballot_coverage_client_search_test

        title 'Search Coverage using a supported combination'

        description %(
          The client demonstrates at least one required server search combination for Coverage.
          Accepted combinations: `patient`.
        )

        def required_search_combinations
          [["patient"]]
        end

        def skip_message
          'Inferno did not receive any search requests for the `Coverage` resource type.'
        end

        def failure_message
          'Inferno did not receive a search for `Coverage` using any of these combinations: ' \
          "#{required_search_combinations.map { |names| names.join(' + ') }.join(', ')}."
        end        

        def all_required_search_parameters
          ["patient"]
        end

        run do
          requests = load_tagged_requests(SEARCH_COVERAGE_TAG)
          skip_if requests.blank?, skip_message

          matching_requests = filter_requests_by_search_parameter_combinations(requests, required_search_combinations)
          assert matching_requests.any?, failure_message

          non_required_search_parameters(matching_requests, all_required_search_parameters).each do |parameter|
            warning "The client used the non-required search parameter `#{parameter}` for `Coverage`. " \
                    'The server may not accept search parameters other than those required by the IG CapabilityStatement.'
          end
        end
      end
    end
  end
end
