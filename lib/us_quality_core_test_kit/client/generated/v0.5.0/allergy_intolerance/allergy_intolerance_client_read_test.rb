# frozen_string_literal: true

module USQualityCoreTestKit
  module Client
    module USQualityCoreClientV050
      class AllergyIntoleranceClientReadTest < Inferno::Test
        id :us_quality_core_v050_allergy_intolerance_client_read_test

        title 'SHALL support read of AllergyIntolerance'

        description %(
          The client demonstrates SHALL support for reading the AllergyIntolerance resource type.
        )

        optional true

        def skip_message
          "Inferno did not receive any read requests for the `AllergyIntolerance` resource type."
        end

        run do
          requests = load_tagged_requests(READ_ALLERGY_INTOLERANCE_TAG)
          skip_if requests.blank?, skip_message
        end
      end
    end
  end
end
