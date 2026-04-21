# frozen_string_literal: true

require 'us_core_test_kit/search_test'

module USQualityCoreTestKit
  module SearchTest
    include USCoreTestKit::SearchTest
    extend USCoreTestKit::SearchTest

    def patient_id_param?(name)
      name == 'patient' || name == 'subject' || (name == '_id' && resource_type == 'Patient')
    end

    def filter_devices(resources)
      resources # NOOP for US Quality Core
    end

    def no_resources_skip_message(resource_type = self.resource_type)
      "No #{resource_type} resources appear to be available. Please use patients with more information"
    end

    def search_param_value(name, resource, include_system: false)
      paths = search_param_paths(name)
      search_value = nil
      paths.each do |path|
        element = find_a_value_at(resource, path) { |element| element_has_valid_value?(element, include_system) }

        search_value =
          case element
          when FHIR::Period
            if element.start.present?
              'gt' + (DateTime.xmlschema(element.start) - 1).xmlschema
            else
              end_datetime = get_fhir_datetime_range(element.end)[:end]
              'lt' + (end_datetime + 1).xmlschema
            end
          when FHIR::Reference
            element.reference
          when FHIR::CodeableConcept
            coding = prefer_well_known_code_system(element, include_system)
            include_system ? "#{coding.system}|#{coding.code}" : coding.code
          when FHIR::Identifier
            include_system ? "#{element.system}|#{element.value}" : element.value
          when FHIR::Coding
            include_system ? "#{element.system}|#{element.code}" : element.code
          when FHIR::HumanName
            element.family || element.given&.first || element.text
          when FHIR::Address
            element.text || element.city || element.state || element.postalCode || element.country
          when Inferno::DSL::PrimitiveType
            element.value
          else
            if metadata.search_definitions[name.to_sym][:type] == 'date' &&
               params_with_comparators&.include?(name)
              # convert date search to greath-than comparator search with correct precision
              # For all date search parameters:
              #   Patient.birthDate does not mandate comparators so cannot be converted
              #   Goal.target-date has day precision
              #   All others have second + time offset precision
              if /^\d{4}(-\d{2})?$/.match?(element) || # YYYY or YYYY-MM
                 (/^\d{4}-\d{2}-\d{2}$/.match?(element) && resource_type != 'Goal') # YYY-MM-DD AND Resource is NOT Goal
                "gt#{(DateTime.xmlschema(element) - 1).xmlschema}"
              else
                element
              end
            else
              element
            end
          end

        break if search_value.present?
      end

      search_value.to_s.gsub(',', '\\,')
    end  
    
    def resource_matches_param?(resource, search_param_name, escaped_search_value, values_found = [])
      search_value = unescape_search_value(escaped_search_value)
      paths = search_param_paths(search_param_name)

      match_found = false

      paths.each do |path|
        type = metadata.search_definitions[search_param_name.to_sym][:type]

        resolve_path(resource, path).each do |value|
          values_found <<
            if value.is_a? FHIR::Reference
              value.reference
            elsif value.is_a? Inferno::DSL::PrimitiveType
              value.value
            else
              value
            end
        end

        values_found.compact!
        match_found =
          case type
          when 'Period', 'date', 'instant', 'dateTime'
            values_found.any? { |date| validate_date_search(search_value, date) }
          when 'HumanName'
            # When a string search parameter refers to the types HumanName and Address,
            # the search covers the elements of type string, and does not cover elements such as use and period
            # https://www.hl7.org/fhir/search.html#string
            search_value_downcase = search_value.downcase
            values_found.any? do |name|
              name&.text&.downcase&.start_with?(search_value_downcase) ||
                name&.family&.downcase&.start_with?(search_value_downcase) ||
                name&.given&.any? { |given| given.downcase.start_with?(search_value_downcase) } ||
                name&.prefix&.any? { |prefix| prefix.downcase.start_with?(search_value_downcase) } ||
                name&.suffix&.any? { |suffix| suffix.downcase.start_with?(search_value_downcase) }
            end
          when 'Address'
            search_value_downcase = search_value.downcase
            values_found.any? do |address|
              address&.text&.downcase&.start_with?(search_value_downcase) ||
                address&.city&.downcase&.start_with?(search_value_downcase) ||
                address&.state&.downcase&.start_with?(search_value_downcase) ||
                address&.postalCode&.downcase&.start_with?(search_value_downcase) ||
                address&.country&.downcase&.start_with?(search_value_downcase)
            end
          when 'CodeableConcept'
            # FHIR token search (https://www.hl7.org/fhir/search.html#token): "When in doubt, servers SHOULD
            # treat tokens in a case-insensitive manner, on the grounds that including undesired data has
            # less safety implications than excluding desired behavior".
            codings = values_found.flat_map(&:coding)
            if search_value.include? '|'
              system = search_value.split('|').first
              code = search_value.split('|').last
              codings&.any? { |coding| coding.system == system && coding.code&.casecmp?(code) }
            else
              codings&.any? { |coding| coding.code&.casecmp?(search_value) }
            end
          when 'Coding'
            if search_value.include? '|'
              system = search_value.split('|').first
              code = search_value.split('|').last
              values_found.any? { |coding| coding.system == system && coding.code&.casecmp?(code) }
            else
              values_found.any? { |coding| coding.code&.casecmp?(search_value) }
            end
          when 'Identifier'
            if search_value.include? '|'
              values_found.any? { |identifier| "#{identifier.system}|#{identifier.value}" == search_value }
            else
              values_found.any? { |identifier| identifier.value == search_value }
            end
          when 'boolean'
            search_values = parse_boolean_search_values(search_value)
            values_found.any? { |value_found| search_values.include?(value_found) }
          when 'string'
            searched_values = search_value.downcase.split(/(?<!\\\\),/).map { |string| string.gsub('\\,', ',') }
            values_found.any? do |value_found|
              searched_values.any? { |searched_value| value_found.downcase.starts_with? searched_value }
            end
          else
            # searching by patient requires special case because we are searching by a resource identifier
            # references can also be URLs, so we may need to resolve those URLs
            if ['subject', 'patient'].include? search_param_name.to_s
              id = search_value.split('Patient/').last
              possible_values = [id, "Patient/#{id}", "#{url}/Patient/#{id}"]
              values_found.any? do |reference|
                possible_values.include? reference
              end
            else
              search_values = search_value.split(/(?<!\\\\),/).map { |string| string.gsub('\\,', ',') }
              values_found.any? { |value_found| search_values.include? value_found }
            end
          end

        break if match_found
      end

      match_found
    end

    def parse_boolean_search_values(search_value)
      search_value
        .split(/(?<!\\\\),/)
        .map { |value| value.gsub('\\,', ',').downcase }
        .filter_map do |value|
          case value
          when 'true'
            true
          when 'false'
            false
          end
        end
    end    
  end
end
