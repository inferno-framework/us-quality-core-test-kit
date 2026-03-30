# frozen_string_literal: true

require 'us_core_test_kit/generator/ig_resources'

module USQualityCoreTestKit
  class Generator
    class IGResources < USCoreTestKit::Generator::IGResources
      def search_param_by_resource_and_name(resource, name)
        # remove '_' from search parameter name, such as _id or _tag
        normalized_name = name.to_s.delete_prefix('_')

        # TODO: We don't need this logic when we don't need SearchParameter overlays
        candidates = resources_by_type['SearchParameter'].select do |param|
          (param.id == "us-quality-core-#{resource.downcase}-#{normalized_name}") || param.name == name
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
    end
  end
end
