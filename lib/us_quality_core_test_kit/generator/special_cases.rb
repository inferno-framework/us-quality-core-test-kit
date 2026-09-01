# frozen_string_literal: true

require_relative 'naming'

module USQualityCoreTestKit
  class Generator
    module SpecialCases
      include Naming

      # The generator will not create tests for resources found in this list
      # for the specified IG versions.
      RESOURCES_TO_EXCLUDE = {
        'Medication' => %w[v050 v100_ballot]
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
        'Encounter' => %w[v050 v100_ballot],
        'Location' => %w[v050 v100_ballot]
      }.freeze

      # Category should be included in the initial search for these profiles.
      ALL_VERSION_CATEGORY_FIRST_PROFILES = [
        CARE_PLAN,
        CONDITION_ENCOUNTER_DIAGNOSIS,
        CONDITION_PROBLEMS_HEALTH_CONCERNS,
        DIAGNOSTIC_REPORT_LAB,
        DIAGNOSTIC_REPORT_NOTE
      ].freeze

      VERSION_SPECIFIC_CATEGORY_FIRST_PROFILES = {
        'http://fhir.org/guides/onc/us-quality-core/StructureDefinition/us-quality-core-careplan' => ['v050'],
        'http://fhir.org/guides/onc/us-quality-core/StructureDefinition/us-quality-core-condition-encounter-diagnosis' => ['v050'],
        'http://fhir.org/guides/onc/us-quality-core/StructureDefinition/us-quality-core-condition-problems-health-concerns' => ['v050'],
        'http://fhir.org/guides/onc/us-quality-core/StructureDefinition/us-quality-core-diagnosticreport-lab' => ['v050'],
        'http://fhir.org/guides/onc/us-quality-core/StructureDefinition/us-quality-core-diagnosticreport-note' => ['v050']

      }.freeze

      PROFILE_CATEGORY_SEARCH_VALUES = {
        OBSERVATION_CLINICAL_RESULT => ['exam'],
        SIMPLE_OBSERVATION => ['activity'],
        OBSERVATION_CANCELLED => ['activity']
      }.freeze

      DO_NOT_PERFORM_PROFILES = [
        DEVICE_NOT_REQUESTED, # v0.5.0
        DEVICE_REQUESTED,
        DEVICE_PROHIBITED,
        MEDICATION_REQUEST_NOT_REQUESTED, # v0.5.0
        MEDICATION_REQUEST_REQUESTED,
        MEDICATION_REQUEST_PROHIBITED,
        SERVICE_NOT_REQUESTED, # v0.5.0
        SERVICE_REQUESTED,
        SERVICE_PROHIBITED
      ].freeze

      class << self
        def exclude_group?(group)
          RESOURCES_TO_EXCLUDE.key?(group.resource) &&
            RESOURCES_TO_EXCLUDE[group.resource].include?(group.reformatted_version)
        end
      end
    end
  end
end
