# frozen_string_literal: true

require 'json'

module USQualityCoreTestKit
  module Client
    class PaginationGroup < Inferno::TestGroup
      id :us_quality_core_client_pagination_group
      title 'Search Result Pagination'
      description %(
        This optional test verifies that the client follows at least one `next`
        pagination link returned in a FHIR search result Bundle.
      )

      optional true

      test do
        id :us_quality_core_client_pagination_test
        title 'Client follows a search result pagination link'
        description %(
          This test passes when Inferno recorded a client request to a URL supplied
          as a `next` link in an earlier search result Bundle. FHIR R4 and US Core
          do not require clients to follow pagination links, so this test is optional.
        )

        optional true

        run do
          requests = load_tagged_requests('us_quality_core_search_request')
          next_page_urls = requests.flat_map { |request| next_page_urls(request) }

          assert next_page_urls.any? { |url| requests.any? { |request| request.url == url } },
                 'Inferno did not receive a request to a `next` pagination link returned in a search result Bundle.'
        end

        def next_page_urls(request)
          JSON.parse(request.response_body)
              .fetch('link', [])
              .filter_map { |link| link['url'] if link['relation'] == 'next' }
        rescue JSON::ParserError, TypeError
          []
        end
      end
    end
  end
end
