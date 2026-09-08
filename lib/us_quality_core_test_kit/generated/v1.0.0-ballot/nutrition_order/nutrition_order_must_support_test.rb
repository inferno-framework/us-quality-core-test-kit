require_relative '../../../must_support_test'

module USQualityCoreTestKit
  module USQualityCoreV100_BALLOT
    class NutritionOrderMustSupportTest < Inferno::Test
      include USQualityCoreTestKit::MustSupportTest

      title 'All must support elements are provided in the NutritionOrder resources returned'

      description %(
        This test will look through the NutritionOrder resources
        found previously for the following Must Support and USCDI-flagged elements:



        For ONC USCDI+ Quality requirements, each NutritionOrder must support the following additional elements:

        * NutritionOrder.enteralFormula
        * NutritionOrder.enteralFormula.baseFormulaType
        * NutritionOrder.enteralFormula.baseFormulaType.extension:codeOptions
        * NutritionOrder.oralDiet
        * NutritionOrder.oralDiet.type
        * NutritionOrder.oralDiet.type.extension:codeOptions
        * NutritionOrder.orderer
        * NutritionOrder.patient
        * NutritionOrder.status
        * NutritionOrder.supplement
        * NutritionOrder.supplement.type
        * NutritionOrder.supplement.type.extension:codeOptions
      )

      id :us_quality_core_v100_ballot_nutrition_order_must_support_test

      def resource_type
        'NutritionOrder'
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:nutrition_order_resources] ||= {}
      end

      run do
        perform_must_support_test(all_scratch_resources)
      end
    end
  end
end
