# frozen_string_literal: true

require 'us_core_test_kit/generator/suite_generator'

require_relative 'naming'
require_relative 'special_cases'

module USQualityCoreTestKit
  class Generator
    class SuiteGenerator < USCoreTestKit::Generator::SuiteGenerator
      def version_specific_message_filters
        [
          # Patient validation warnings suppressed for US Core extensions because
          # validator tries to validate against different US Core version than we require
          %r{Patient.*Patient\.extension\[\d+\]\[url='http://hl7\.org/fhir/us/core/StructureDefinition/us-core-(race|ethnicity|tribal-affiliation)\|\d+\.\d+(?:\.\d+)?'\]:\s*The extension URL must not contain a version\.},
          %r{Patient.*Patient\.extension\[\d+\]\.url:\s*Value is 'http://hl7\.org/fhir/us/core/StructureDefinition/us-core-(race|ethnicity|tribal-affiliation)\|\d+\.\d+(?:\.\d+)?'\s*but is fixed to 'http://hl7\.org/fhir/us/core/StructureDefinition/us-core-(race|ethnicity|tribal-affiliation)'\s*in the profile http://hl7\.org/fhir/us/core/StructureDefinition/us-core-(race|ethnicity|tribal-affiliation)\|\d+\.\d+(?:\.\d+)?#Extension\.url},
          # This extension is correct but is not yet correctly passing in the validator
          %r{DeviceRequest.*DeviceRequest\.modifierExtension\[\d+\]:\s*Slicing cannot be evaluated:\s*Unable to resolve profile CanonicalType\[http://hl7\.org/fhir/5\.0/StructureDefinition/extension-DeviceRequest\.doNotPerform\]}
        ]
      end

      def template
        @template ||= File.read(File.join(__dir__, 'templates', 'suite.rb.erb'))
      end

      def base_output_file_name
        'us_quality_core_test_suite.rb'
      end

      def class_name
        'USQualityCoreTestSuite'
      end

      def ig_tgz
        "igs/us_quality_core_#{ig_metadata.reformatted_version}.tgz"
      end

      def module_name
        "USCore#{ig_metadata.reformatted_version.upcase}"
      end

      def suite_id
        "us_quality_core_#{ig_metadata.reformatted_version}"
      end

      def fhir_api_group_id
        "us_quality_core_#{ig_metadata.reformatted_version}_fhir_api"
      end

      def title
        "US Quality Core Server #{ig_metadata.ig_version}"
      end

      def ig_identifier
        version = ig_metadata.ig_version[1..] # Remove leading 'v'
        "fhir.onc.us-quality-core##{version}"
      end

      def ig_link
        Naming.ig_link(ig_metadata.ig_version)
      end

      def groups
        ig_metadata.ordered_groups.reject { |group| SpecialCases.exclude_group? group }.uniq(&:id)
      end

      def group_id_list
        @group_id_list ||= groups.map(&:id)
      end
    end
  end
end
