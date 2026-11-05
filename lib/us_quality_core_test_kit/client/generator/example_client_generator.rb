# frozen_string_literal: true

require 'erb'
require 'json'
require 'uri'

require_relative '../../generator/naming'
require_relative '../../generator/special_cases'

module USQualityCoreTestKit
  module Client
    class Generator
      class ExampleSearchParameterBuilder
        def search_param_value(name, group, patient_id, profile_identifier)
          return USQualityCoreTestKit::Generator::Naming.instance_id_for_profile(profile_identifier) if name == '_id'
          return patient_id if %w[patient subject].include?(name)

          definition = group.search_definitions.fetch(name.to_sym)
          value = Array(definition[:values]).first
          return value unless value.nil?

          # Client tests check parameter names. Use syntactically valid placeholders
          # for the example requests without requiring matching reference-server data.
          case definition[:type]
          when 'Period', 'date', 'dateTime', 'instant'
            '2000-01-01'
          when 'boolean'
            'true'
          when 'integer', 'decimal', 'positiveInt', 'unsignedInt', 'Quantity'
            '1'
          when 'uri', 'url', 'canonical'
            'http://example.org/example'
          else
            'dummy'
          end
        end
      end

      class ExampleClientGenerator
        class << self
          def generate(ig_metadata, base_output_dir)
            new(ig_metadata, base_output_dir).generate
          end
        end

        attr_accessor :ig_metadata, :base_output_dir

        def initialize(ig_metadata, base_output_dir)
          self.ig_metadata = ig_metadata
          self.base_output_dir = base_output_dir
        end

        def template
          @template ||= File.read(File.join(__dir__, 'templates', 'example_client.postman_collection.json.erb'))
        end

        def search_parameter_builder
          @search_parameter_builder ||= ExampleSearchParameterBuilder.new
        end

        def description
          'Demonstration Postman collection for running against the US Quality Core ' \
            "#{ig_metadata.reformatted_version} client suite. " \
            'Search values come from IG metadata or placeholders and may return empty Bundles.'
        end

        def groups
          ig_metadata.ordered_groups.reject { |group| USQualityCoreTestKit::Generator::SpecialCases.exclude_group? group }
        end

        def requests
          by_profile = {}

          patient_id = USQualityCoreTestKit::Generator::Naming.instance_id_for_profile('patient')

          groups.each do |group|
            details = {}

            profile_identifier = USQualityCoreTestKit::Generator::Naming.snake_case_for_profile(group)
            resource_ids = [USQualityCoreTestKit::Generator::Naming.instance_id_for_profile(profile_identifier)]
            resource_ids << USQualityCoreTestKit::Generator::Naming.instance_id_for_profile('observation_lab') if profile_identifier == 'observation_clinical_result'
            details[:read_ids] = resource_ids

            searches =
              group.searches.map do |search|
                {
                  params: search[:names].to_h do |name|
                    [
                      name,
                      search_parameter_builder.search_param_value(name, group, patient_id, profile_identifier)
                    ]
                  end
                }
              end
            details[:searches] = searches

            details[:resource] = group.resource

            by_profile[group.title] = details
          end

          by_profile
        end

        def postman_collection
          {
            info: {
              name: "US Quality Core #{ig_metadata.reformatted_version} Example Client",
              description:,
              schema: 'https://schema.getpostman.com/json/collection/v2.1.0/collection.json'
            },
            variable: collection_variables,
            item: items
          }
        end

        def output
          @output ||= ERB.new(template, trim_mode: '-').result(binding)
        end

        def base_output_file_name
          "example_client_#{ig_metadata.reformatted_version.downcase}.postman_collection.json"
        end

        def output_file_name
          File.join(base_output_dir, base_output_file_name)
        end

        def generate
          File.write(output_file_name, output)
        end

        def collection_variables
          [
            {
              key: 'base_url',
              value: "http://localhost:4567/custom/us_quality_core_client_#{ig_metadata.reformatted_version}/fhir",
              type: 'string'
            },
            { key: 'access_token', value: '', type: 'string' }
          ]
        end

        def items
          requests.map do |title, details|
            {
              name: title,
              item: [
                *details[:read_ids].map { |id| read_item(details[:resource], id) },
                *details[:searches].map { |search| search_item(details[:resource], search[:params]) }
              ]
            }
          end
        end

        def read_item(resource, id)
          {
            name: "Read #{resource}/#{id}",
            request: get_request("#{resource}/#{id}"),
            event: [test_event(read_test_script(resource))]
          }
        end

        def search_item(resource, params)
          {
            name: "Search #{resource} #{params.keys.join(' + ')}",
            request: get_request("#{resource}?#{URI.encode_www_form(params.transform_values(&:to_s))}"),
            event: [test_event(search_test_script)]
          }
        end

        def get_request(path)
          {
            method: 'GET',
            header: [
              { key: 'Accept', value: 'application/fhir+json' },
              { key: 'Authorization', value: 'Bearer {{access_token}}' }
            ],
            url: "{{base_url}}/#{path}"
          }
        end

        def test_event(script)
          { listen: 'test', script: { type: 'text/javascript', exec: script } }
        end

        def read_test_script(resource)
          success_response_test +
            [
              '',
              "pm.test('response body is a #{resource} resource', function () {",
              '  const body = pm.response.json();',
              "  pm.expect(body.resourceType).to.eql('#{resource}');",
              '});'
            ]
        end

        def search_test_script
          success_response_test +
            [
              '',
              "pm.test('response body is a search Bundle', function () {",
              '  const body = pm.response.json();',
              "  pm.expect(body.resourceType).to.eql('Bundle');",
              '});',
              '',
              'const bundle = pm.response.json();',
              'if (!Array.isArray(bundle.entry) || bundle.entry.length === 0) {',
              "  const selfLink = (bundle.link || []).find((link) => link.relation === 'self');",
              '  console.warn(`SKIP: ${selfLink?.url || pm.info.requestName} - search response bundle was empty`);',
              '}'
            ]
        end

        def success_response_test
          [
            "pm.test('response status is 2xx', function () {",
            '  pm.expect(pm.response.code).to.be.within(200, 299);',
            '});'
          ]
        end
      end
      # rubocop:enable Metrics/ClassLength
    end
  end
end
