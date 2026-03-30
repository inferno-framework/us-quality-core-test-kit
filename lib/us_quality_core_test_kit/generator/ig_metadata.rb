# frozen_string_literal: true

require 'us_core_test_kit/generator/ig_metadata'
require_relative 'special_cases'

module USQualityCoreTestKit
  class Generator
    class IGMetadata < USCoreTestKit::Generator::IGMetadata
      def delayed_profiles
        @delayed_profiles ||=
          delayed_groups.reject { |group| SpecialCases.exclude_group?(group) }.map(&:profile_url)
      end
    end
  end
end
