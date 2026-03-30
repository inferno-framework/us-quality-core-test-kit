# frozen_string_literal: true

require_relative 'value_extractor'

require 'us_core_test_kit/generator/must_support_metadata_extractor'

module USQualityCoreTestKit
  class Generator
    class MustSupportMetadataExtractor < USCoreTestKit::Generator::MustSupportMetadataExtractor
      def uscdi_plus_quality_element?(element)
        !element.mustSupport && element.extension.any? do |extension|
          extension.url.downcase.ends_with? 'uscdiplusquality'
        end
      end

      def add_us_quality_coreuscdi_plus_quality_flag(profile_element, metadata_element)
        if uscdi_plus_quality_element?(profile_element)
          metadata_element.merge(us_quality_coreuscdi_plus_quality: true)
        else
          metadata_element
        end
      end

      def all_must_support_elements
        profile_elements.select do |element|
          element.mustSupport || uscdi_plus_quality_element?(element) || is_uscdi_requirement_element?(element)
        end
      end

      def must_support_extensions
        super.map do |extension|
          profile_element = must_support_extension_elements.find { |e| e.id == extension[:id] }

          add_us_quality_coreuscdi_plus_quality_flag(profile_element, extension)
        end
      end

      def must_support_slices
        super.map do |slice|
          profile_element = must_support_slice_elements.find { |e| e.id == slice[:slice_id] }

          add_us_quality_coreuscdi_plus_quality_flag(profile_element, slice)
        end
      end

      def must_support_elements
        super.map do |element|
          profile_element = plain_must_support_elements.find do |e|
            path = e.id.gsub("#{resource}.", '')
            [element[:path], element[:original_path]].include?(path)
          end

          add_us_quality_coreuscdi_plus_quality_flag(profile_element, element)
        end
      end

      # Aligns US Core v6.1.0 must support requirements to [USCDI v3.1](https://isp.healthit.gov/united-states-core-data-interoperability-uscdi#uscdi-v3-1)
      def remove_patient_gender_identity
        return unless profile.type == 'Patient'
        return unless @must_supports && @must_supports[:extensions]

        @must_supports[:extensions].delete_if { |extension| extension[:id] == 'Patient.extension:genderIdentity' }
      end

      def handle_special_cases
        remove_patient_gender_identity
      end
    end
  end
end
