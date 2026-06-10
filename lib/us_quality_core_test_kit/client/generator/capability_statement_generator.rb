# frozen_string_literal: true

require 'erb'
require 'json'

require_relative '../../generator/special_cases'

module USQualityCoreTestKit
  module Client
    class Generator
      class CapabilityStatementGenerator
        class << self
          def generate(ig_metadata, ig_resources, base_output_dir)
            new(ig_metadata, ig_resources, base_output_dir).generate
          end
        end

        attr_accessor :ig_metadata, :ig_resources, :base_output_dir

        def initialize(ig_metadata, ig_resources, base_output_dir)
          self.ig_metadata = ig_metadata
          self.ig_resources = ig_resources
          self.base_output_dir = base_output_dir
        end

        def generate
          File.write(output_file_name, output)
        end

        def output_dir
          base_output_dir
        end

        def output_file_name
          File.join(output_dir, "capability_statement_#{ig_metadata.reformatted_version.downcase}.json.erb")
        end

        def template
          @template ||= File.read(File.join(__dir__, 'templates', 'capability_statement.json.erb'))
        end

        def output
          @output ||= ERB.new(template, trim_mode: '-').result(binding)
        end

        def resource_metadata
          groups
            .group_by(&:resource)
            .sort
            .map do |resource_type, resource_groups|
              resource_metadata_for(resource_type, resource_groups)
            end
        end

        def resource_metadata_for(resource_type, resource_groups)
          resource = {
            type: resource_type,
            supportedProfile: resource_groups.map(&:profile_url).uniq,
            interaction: interaction_codes(resource_groups).map { |code| { code: code } }
          }

          search_params = search_params_for(resource_groups)
          resource[:searchParam] = search_params if search_params.present?

          resource
        end

        def groups
          ig_metadata.ordered_groups
                     .reject { |group| USQualityCoreTestKit::Generator::SpecialCases.exclude_group? group }
                     .uniq(&:profile_url)
        end

        def interaction_codes(resource_groups)
          resource_groups.flat_map(&:interactions)
                         .filter_map { |interaction| interaction[:code] || interaction['code'] }
                         .uniq
        end

        def search_params_for(resource_groups)
          resource_groups.each_with_object({}) do |group, search_params|
            group.searches.each do |search|
              search[:names].each do |name|
                search_params[name] ||= search_param_metadata(group, name)
              end
            end
          end.values
        end

        def search_param_metadata(group, name)
          {
            name: name,
            type: search_param_type(group, name)
          }
        end

        def search_param_type(group, name)
          search_param = ig_resources.search_param_by_resource_and_name(group.resource, name)
          raise "No SearchParameter found for #{group.resource} #{name}" if search_param.nil?

          search_param.type
        end
      end
    end
  end
end
