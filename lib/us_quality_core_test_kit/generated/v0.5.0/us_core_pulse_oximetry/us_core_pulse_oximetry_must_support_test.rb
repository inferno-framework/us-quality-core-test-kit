require_relative '../../../must_support_test'

module USQualityCoreTestKit
  module USQualityCoreV050
    class UsCorePulseOximetryMustSupportTest < Inferno::Test
      include USQualityCoreTestKit::MustSupportTest

      title 'All must support elements are provided in the Observation resources returned'

      description %(
        This test will look through the Observation resources
        found previously for the following Must Support and USCDI-flagged elements:

        * Observation.category
        * Observation.category:VSCat
        * Observation.category:VSCat.coding
        * Observation.category:VSCat.coding.code
        * Observation.category:VSCat.coding.system
        * Observation.code
        * Observation.code.coding
        * Observation.code.coding:O2Sat
        * Observation.code.coding:PulseOx
        * Observation.component
        * Observation.component.code
        * Observation.component.dataAbsentReason
        * Observation.component.valueQuantity
        * Observation.component:Concentration
        * Observation.component:Concentration.code
        * Observation.component:Concentration.dataAbsentReason
        * Observation.component:Concentration.valueQuantity
        * Observation.component:Concentration.valueQuantity.code
        * Observation.component:Concentration.valueQuantity.system
        * Observation.component:Concentration.valueQuantity.unit
        * Observation.component:Concentration.valueQuantity.value
        * Observation.component:FlowRate
        * Observation.component:FlowRate.code
        * Observation.component:FlowRate.dataAbsentReason
        * Observation.component:FlowRate.valueQuantity
        * Observation.component:FlowRate.valueQuantity.code
        * Observation.component:FlowRate.valueQuantity.system
        * Observation.component:FlowRate.valueQuantity.unit
        * Observation.component:FlowRate.valueQuantity.value
        * Observation.dataAbsentReason
        * Observation.effectiveDateTime
        * Observation.status
        * Observation.subject
        * Observation.valueQuantity
        * Observation.valueQuantity:valueQuantity.code
        * Observation.valueQuantity:valueQuantity.system
        * Observation.valueQuantity:valueQuantity.unit
        * Observation.valueQuantity:valueQuantity.value
        * Observation.value[x]:valueQuantity
      )

      id :us_quality_core_v050_us_core_pulse_oximetry_must_support_test

      def resource_type
        'Observation'
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:us_core_pulse_oximetry_resources] ||= {}
      end

      run do
        perform_must_support_test(all_scratch_resources)
      end
    end
  end
end
