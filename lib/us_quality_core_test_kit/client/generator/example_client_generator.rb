# frozen_string_literal: true

require_relative '../../generator/naming'
require_relative '../../generator/special_cases'

module USQualityCoreTestKit
  module Client
    class Generator
      class ExampleClientGenerator
        class << self
          def generate(ig_metadata)
            new(ig_metadata).generate
          end
        end

        attr_accessor :ig_metadata

        def initialize(ig_metadata)
          self.ig_metadata = ig_metadata
        end

        def template
          @template ||= File.read(File.join(__dir__, 'templates', 'example_client.rb.erb'))
        end

        def base_output_dir
          'client-example-resources'
        end

        def description
          "Demonstration script for running against the US Quality Core #{ig_metadata.reformatted_version} client suite."
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

            searches = []
            group.searches.each do |search|
              search[:names].each do |name|
                if name == '_id'
                  searches << { param: name, value: USQualityCoreTestKit::Generator::Naming.instance_id_for_profile(profile_identifier) }
                elsif %w[patient subject].include?(name)
                  searches << { param: name, value: patient_id }
                end
              end
            end
            details[:searches] = searches

            details[:resource] = group.resource

            by_profile[group.title] = details
          end

          by_profile
        end

        def output
          @output ||= ERB.new(template, trim_mode: '-').result(binding)
        end

        def base_output_file_name
          "example_client_#{ig_metadata.reformatted_version.downcase}.rb"
        end

        def output_file_name
          File.join(base_output_dir, base_output_file_name)
        end

        def generate
          File.write(output_file_name, output)
        end
      end
    end
  end
end
