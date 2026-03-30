# frozen_string_literal: true

module USQualityCoreTestKit
  module Client
    class Generator
      class IGResources < USQualityCoreTestKit::Generator::IGResources
        def capability_statement(mode = 'client')
          resources_by_type['CapabilityStatement'].find do |capability_statement_resource|
            capability_statement_resource.rest.any? { |r| r.mode == mode }
          end
        end
      end
    end
  end
end
