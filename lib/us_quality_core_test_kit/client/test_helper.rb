# frozen_string_literal: true

module USQualityCoreTestKit
  module Client
    module TestHelper
      def filter_requests_by_resource_type(requests, resource_type)
        requests.select do |request|
          request.url.split('/').any? { |segment| segment.split('?').first&.casecmp?(resource_type) }
        end
      end

      def filter_requests_by_resource_id(requests, resource_id)
        Array(resource_id).flat_map do |id|
          requests.select do |request|
            request.url.split('/').last.split('?').first&.casecmp?(id)
          end
        end
      end

      def filter_requests_by_search_parameters(requests, search_parameters)
        requests.select do |request|
          included_params = search_parameters_for_request(request)
          next unless included_params.present?

          search_parameters.all? { |param| included_params.include? param }
        end
      end

      def non_required_search_parameters(requests, required_search_parameters)
        requests
          .flat_map { |request| search_parameters_for_request(request) || [] }
          .uniq
          .difference(required_search_parameters)
      end

      def search_parameters_for_request(request)
        if request.verb.downcase == 'get'
          url_params(request.url).keys
        elsif request.verb.downcase == 'post'
          CGI.parse(request.request_body).keys
        end
      end

      def url_params(url)
        CGI.parse(URI.parse(url).query)
      end
    end
  end
end
