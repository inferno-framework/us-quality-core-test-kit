# frozen_string_literal: true

require_relative '../../generator/naming'
require_relative '../../generator/special_cases'

module USQualityCoreTestKit
  module Client
    class Generator
      class NonRequiredSearchParametersTestGenerator
        class << self
          def generate(ig_metadata, base_output_dir)
            ig_metadata.groups
                       .reject { |group| USQualityCoreTestKit::Generator::SpecialCases.exclude_group? group }
                       .select { |group| group.searches.present? }
                       .each { |group| new(group, base_output_dir).generate }
          end
        end

        attr_accessor :group_metadata, :base_output_dir

        def initialize(group_metadata, base_output_dir)
          self.group_metadata = group_metadata
          self.base_output_dir = base_output_dir
        end

        def generate
          FileUtils.mkdir_p(output_file_directory)
          File.write(output_file_name, output)
          group_metadata.add_test(id: test_id, file_name: base_output_file_name)
        end

        def template
          @template ||= File.read(File.join(__dir__, 'templates', 'non_required_search_parameters_test.rb.erb'))
        end

        def output
          @output ||= ERB.new(template, trim_mode: '-').result(binding)
        end

        def profile_identifier
          USQualityCoreTestKit::Generator::Naming.snake_case_for_profile(group_metadata)
        end

        def class_name
          "#{profile_identifier.camelize}NonRequiredSearchParametersClientSearchTest"
        end

        def test_id
          "us_quality_core_#{group_metadata.reformatted_version}_#{class_name.underscore}"
        end

        def base_output_file_name
          "#{class_name.underscore}.rb"
        end

        def output_file_directory
          File.join(base_output_dir, profile_identifier)
        end

        def output_file_name
          File.join(output_file_directory, base_output_file_name)
        end

        def module_name
          "USQualityCoreClient#{group_metadata.reformatted_version.upcase}"
        end

        def resource
          group_metadata.resource
        end

        def required_search_parameters
          group_metadata.searches
                        .select { |search| search[:expectation] == 'SHALL' }
                        .flat_map { |search| search[:names] }
                        .uniq
        end
      end
    end
  end
end
