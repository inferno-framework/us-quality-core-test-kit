# frozen_string_literal: true

require_relative '../../generator/group_generator'
require_relative '../../generator/naming'
require_relative '../../generator/special_cases'

module USQualityCoreTestKit
  module Client
    class Generator
      class GroupGenerator < USQualityCoreTestKit::Generator::GroupGenerator
        def template
          @template ||= File.read(File.join(__dir__, 'templates', 'group.rb.erb'))
        end

        def output
          @output ||= ERB.new(template, trim_mode: '-').result(binding)
        end

        def class_name
          "#{profile_identifier.camelize}ClientGroup"
        end

        def module_name
          "USQualityCoreClient#{group_metadata.reformatted_version.upcase}"
        end

        def group_id
          "us_quality_core_client_#{group_metadata.reformatted_version}_#{profile_identifier}"
        end

        def description
          <<~DESCRIPTION

            # Background

            This test group verifies that the client can access #{resource_type} data
            conforming to the #{profile_name}.

            # Testing Methodology

            ## Data Access Supported

            Clients may not be required to support the #{resource_type} FHIR resource type. However, if they
            do support it, they must support the #{profile_name} and use a supported search to access its data.
            The tests in this group will not execute if client makes no attempt to access data for the
            #{resource_type} resource type. In this case, the test will be marked as skip if support
            for the resource type is required, and omitted otherwise.

            ## Reading
            This test checks that the client performed a read of any #{resource_type} resource, regardless of its ID.

            ## Searching
            The client must demonstrate at least one of the following search parameter
            combinations supported by the server for #{resource_type}:

            #{search_param_name_string}

          DESCRIPTION
        end

        def conformance_optional?
          group_metadata.resource_conformance_expectation != 'SHALL'
        end

        def generate
          File.write(output_file_name, output)
          group_metadata.id = group_id
          group_metadata.file_name = base_output_file_name
        end
      end
    end
  end
end
