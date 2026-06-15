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
        attr_accessor :bundle_file_name

        def initialize(bundle_file_name)
          self.bundle_file_name = bundle_file_name
        end

        def resource(resource_type, resource_id)
          resource_by_type_and_id.fetch([resource_type, resource_id])
        end

        def search_param_value(name, group, resource, patient_id, profile_identifier)
          return USQualityCoreTestKit::Generator::Naming.instance_id_for_profile(profile_identifier) if name == '_id'
          return patient_id if %w[patient subject].include?(name)

          definition = group.search_definitions[name.to_sym]
          value = Array(definition[:paths]).flat_map { |path| values_at_path(resource, path) }.compact.first
          value ||= Array(definition[:values]).first

          format_search_value(value, definition[:type])
        end

        def bundle_resources
          @bundle_resources ||= JSON.parse(File.read(bundle_file_name))['entry'].map { |entry| entry['resource'] }
        end

        def resource_by_type_and_id
          @resource_by_type_and_id ||=
            bundle_resources.each_with_object({}) do |resource, resources|
              resources[[resource['resourceType'], resource['id']]] = resource
            end
        end

        def values_at_path(resource, path)
          extension_match = path.match(/\A(?<extension_type>modifierExtension|extension)\.where\(url='(?<url>[^']+)'\)\.(?<value_path>\w+)\z/)
          return extension_values(resource, extension_match) if extension_match

          path.split('.').reduce([resource]) do |values, segment|
            values.flat_map { |value| child_values(value, segment) }
          end
        end

        def extension_values(resource, match)
          Array(resource[match[:extension_type]])
            .select { |extension| extension['url'] == match[:url] }
            .flat_map { |extension| child_values(extension, match[:value_path]) }
        end

        def child_values(value, segment)
          case value
          when Array
            value.flat_map { |child| child_values(child, segment) }
          when Hash
            return resolved_reference_values(value) if segment == 'resolve()'

            if value.key?(segment)
              [value[segment]]
            else
              value
                .select { |key, _child| key.match?(/\A#{Regexp.escape(segment)}[A-Z]/) }
                .values
            end
          else
            []
          end
        end

        def resolved_reference_values(value)
          reference = value['reference']
          return [] if reference.nil? || reference.start_with?('#')

          resource_type, resource_id = resource_type_and_id_from_reference(reference)
          resolved_resource = resource_by_type_and_id[[resource_type, resource_id]]

          resolved_resource.nil? ? [] : [resolved_resource]
        end

        def resource_type_and_id_from_reference(reference)
          parts = reference.split('/')
          history_index = parts.index('_history')
          parts = parts.first(history_index) if history_index

          parts.last(2)
        end

        def format_search_value(value, type)
          case value
          when Array
            value.filter_map { |item| format_search_value(item, type) }.first
          when Hash
            format_hash_search_value(value, type)
          else
            format_primitive_search_value(value, type)
          end
        end

        def format_hash_search_value(value, type)
          return value['reference'] if value['reference'].present?
          return value.dig('coding', 0, 'code') if value['coding'].present?
          return value['code'] if value['code'].present?
          return value['value'] if value['value'].present?
          return format_primitive_search_value(value['start'] || value['end'], type) if value['start'].present? || value['end'].present?

          nil
        end

        def format_primitive_search_value(value, type)
          return value unless value.is_a?(String) && %w[Period date dateTime instant].include?(type)

          # Date searches are only checked for the parameter name in client tests, but the
          # example client still needs a non-empty response so it can keep making requests.
          # Use an inclusive lower bound for date-like fields, including Period starts.
          "ge#{value.first(10)}"
        end
      end

      # rubocop:disable Metrics/ClassLength
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

        def client_example_resources_dir
          'client-example-resources'
        end

        def bundle_file_name
          File.join(client_example_resources_dir, 'us_quality_core_bundle_patient.json')
        end

        def search_parameter_builder
          @search_parameter_builder ||= ExampleSearchParameterBuilder.new(bundle_file_name)
        end

        def description
          'Demonstration Postman collection for running against the US Quality Core ' \
            "#{ig_metadata.reformatted_version} client suite."
        end

        def groups
          ig_metadata.ordered_groups.reject { |group| USQualityCoreTestKit::Generator::SpecialCases.exclude_group? group }
        end

        def requests
          by_profile = {}

          patient_id = nil

          groups.each do |group|
            details = {}

            profile_identifier = USQualityCoreTestKit::Generator::Naming.snake_case_for_profile(group)
            resource_ids = [USQualityCoreTestKit::Generator::Naming.instance_id_for_profile(profile_identifier)]
            resource_ids << USQualityCoreTestKit::Generator::Naming.instance_id_for_profile('observation_lab') if profile_identifier == 'observation_clinical_result'
            details[:read_ids] = resource_ids

            patient_id = USQualityCoreTestKit::Generator::Naming.instance_id_for_profile(profile_identifier) if group.resource == 'Patient'
            resource = search_parameter_builder.resource(group.resource, resource_ids.first)

            searches =
              group.searches.map do |search|
                {
                  params: search[:names].to_h do |name|
                    [
                      name,
                      search_parameter_builder.search_param_value(name, group, resource, patient_id, profile_identifier)
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
