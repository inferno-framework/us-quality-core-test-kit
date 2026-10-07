# frozen_string_literal: true

module USQualityCoreTestKit
  module Client
    module USQualityCoreClientV050
      class ImmunizationClientReadTest < Inferno::Test
        id :us_quality_core_v050_immunization_client_read_test

        title 'SHALL support read of Immunization'

        description %(
          The client demonstrates SHALL support for reading the Immunization resource type.
        )

        optional true

        def skip_message
          "Inferno did not receive any read requests for the `Immunization` resource type."
        end

        run do
          requests = load_tagged_requests(READ_IMMUNIZATION_TAG)
          skip_if requests.blank?, skip_message
        end
      end
    end
  end
end
