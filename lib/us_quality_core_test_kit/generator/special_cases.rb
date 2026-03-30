# frozen_string_literal: true

require_relative 'naming'

module USQualityCoreTestKit
  class Generator
    module SpecialCases
      include Naming

      # The generator will not create tests for resources found in this list
      # for the specified IG versions.
      RESOURCES_TO_EXCLUDE = {
        'Medication' => %w[v010]
      }.freeze

      # This list is meant to capture "abstract" profiles that do not themselves
      # need tests. Instead, tests will be generated for their descendent
      # profiles. This list is not IG version specific.
      PROFILES_TO_EXCLUDE = [].freeze

      # The generator will create optional test groups for these resources. If a
      # client or server supports them, the client or server must pass all of the
      # associated tests. This list is not IG version specific.
      OPTIONAL_RESOURCES = [
        'PractitionerRole'
      ].freeze

      # The generator will create optional test groups for these profiles. If a
      # client or server supports them, the client or server must pass all of the
      # associated tests.
      OPTIONAL_PROFILES = {}.freeze

      # These resources will be gathered for testing via references from other
      # resources.
      DELAYED = {
        'Encounter' => %w[v010],
        'Location' => %w[v010]
      }.freeze

      # Category should be included in the initial search for these profiles.
      ALL_VERSION_CATEGORY_FIRST_PROFILES = [
        CARE_PLAN,
        DIAGNOSTIC_REPORT_LAB,
        DIAGNOSTIC_REPORT_NOTE,
        SIMPLE_OBSERVATION,
        NON_PATIENT_OBSERVATION,
        LABORATORY_RESULT_OBSERVATION,
        OBSERVATION_CLINICAL_RESULT,
        OBSERVATION_SCREENING_ASSESSMENT,
        CONDITION_ENCOUNTER_DIAGNOSIS,
        CONDITION_PROBLEMS_HEALTH_CONCERNS,
        SERVICE_REQUEST,
        SERVICE_NOT_REQUESTED
      ].freeze

      VERSION_SPECIFIC_CATEGORY_FIRST_PROFILES = {}.freeze

      class << self
        def exclude_group?(group)
          RESOURCES_TO_EXCLUDE.key?(group.resource) &&
            RESOURCES_TO_EXCLUDE[group.resource].include?(group.reformatted_version)
        end
      end
    end
  end
end
