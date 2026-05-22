require 'us_core_test_kit/generator/provenance_revinclude_search_test_generator'

require_relative 'naming'
require_relative 'special_cases'

module USQualityCoreTestKit
  class Generator
    class ProvenanceRevincludeSearchTestGenerator < USCoreTestKit::Generator::ProvenanceRevincludeSearchTestGenerator
      def template
        @template ||= File.read(File.join(__dir__, 'templates', 'provenance_revinclude_search.rb.erb'))
      end
    end
  end
end
