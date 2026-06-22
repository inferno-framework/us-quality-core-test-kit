# frozen_string_literal: true


module USQualityCoreTestKit
  class Generator
    class IGResources
      def add(resource)
        resources_by_type[resource.resourceType] << resource
      end

      def ig
        resources_by_type['ImplementationGuide'].first
      end

      def inspect
        'IGResources'
      end

      def value_set_by_url(url)
        resources_by_type['ValueSet'].find { |profile| profile.url == url }
      end

      def code_system_by_url(url)
        resources_by_type['CodeSystem'].find { |system| system.url == url }
      end

      def capability_statement(mode = 'server')
        resources_by_type['CapabilityStatement'].reverse.find do |capability_statement_resource|
          capability_statement_resource.rest.any? { |r| r.mode == mode }
        end
      end

      def profile_by_url(url)
        return if url.nil? || url.empty?

        normalized_url = url.split('|').first

        resources_by_type['StructureDefinition'].find do |profile|
          profile.url == normalized_url || profile.id == normalized_url
        end
      end

      def resource_for_profile(url)
        profile_by_url(url).type
      end

      def search_param_by_resource_and_name(resource, name)
        # remove '_' from search parameter name, such as _id or _tag
        normalized_name = name.to_s.delete_prefix('_')

        # The below logic adds support for SearchParameter overlays
        candidates = resources_by_type['SearchParameter'].select do |param|
          exact_id_match = [
            "us-quality-core-#{resource.downcase}-#{normalized_name}",
            "us-core-#{resource.downcase}-#{normalized_name}"
          ].include?(param.id)
          resource_scoped_code_match = Array(param.base).include?(resource) &&
                                       (param.name == name || param.code == name)

          exact_id_match || resource_scoped_code_match
        end

        return candidates.first if candidates.length <= 1

        expression_candidates = candidates.select { |p| p.respond_to?(:expression) && p.expression.to_s.strip != '' }

        direct_matches = expression_candidates.select do |p|
          expression = p.expression.to_s
          expression.include?("#{resource}.") && expression.match?(/\.[A-Za-z]+/) && expression.include?(".#{normalized_name}")
        end
        return direct_matches.first unless direct_matches.empty?

        resource_scoped = expression_candidates.select { |p| p.expression.to_s.lstrip.start_with?("#{resource}.") }
        return resource_scoped.first unless resource_scoped.empty?

        candidates.first
      end

      private

      def resources_by_type
        @resources_by_type ||= Hash.new { |hash, key| hash[key] = [] }
      end
    end
  end
end
