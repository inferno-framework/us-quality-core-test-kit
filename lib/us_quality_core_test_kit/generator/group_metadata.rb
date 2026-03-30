# frozen_string_literal: true

require_relative 'special_cases'

require 'us_core_test_kit/generator/group_metadata'

module USQualityCoreTestKit
  class Generator
    class GroupMetadata < USCoreTestKit::Generator::GroupMetadata
      def delayed?
        # rubocop:disable Naming/MemoizedInstanceVariableName
        # @is_delayed is used in USCoreTestKit::Generator::GroupMetadata
        @is_delayed ||= if resource == 'Patient'
                          false
                        else
                          no_patient_searches? || special_delayed_resource?
                        end
        # rubocop:enable Naming/MemoizedInstanceVariableName
      end

      def no_patient_searches?
        searches.none? do |search|
          search[:expectation] == 'SHALL' &&
            (search[:names].include?('patient') || search[:names].include?('subject'))
        end
      end

      def special_delayed_resource?
        SpecialCases::DELAYED.key?(resource) && SpecialCases::DELAYED[resource].include?(reformatted_version)
      end
    end
  end
end
