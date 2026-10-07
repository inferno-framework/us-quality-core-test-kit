# frozen_string_literal: true

module USQualityCoreTestKit
  module Client
    module USQualityCoreClientV100_BALLOT
      class NutritionOrderClientReadTest < Inferno::Test
        id :us_quality_core_v100_ballot_nutrition_order_client_read_test

        title 'SHALL support read of NutritionOrder'

        description %(
          The client demonstrates SHALL support for reading the NutritionOrder resource type.
        )

        optional true

        def skip_message
          "Inferno did not receive any read requests for the `NutritionOrder` resource type."
        end

        run do
          requests = load_tagged_requests(READ_NUTRITION_ORDER_TAG)
          skip_if requests.blank?, skip_message
        end
      end
    end
  end
end
