# frozen_string_literal: true

require 'us_core_test_kit/generator/ig_loader'

require_relative 'ig_resources'

module USQualityCoreTestKit
  class Generator
    class IGLoader < USCoreTestKit::Generator::IGLoader
      def ig_resources
        @ig_resources ||= IGResources.new
      end
    end
  end
end
