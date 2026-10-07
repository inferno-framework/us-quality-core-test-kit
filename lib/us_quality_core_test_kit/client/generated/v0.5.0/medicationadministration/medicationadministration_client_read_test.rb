# frozen_string_literal: true

module USQualityCoreTestKit
  module Client
    module USQualityCoreClientV050
      class MedicationadministrationClientReadTest < Inferno::Test
        id :us_quality_core_v050_medicationadministration_client_read_test

        title 'SHALL support read of MedicationAdministration'

        description %(
          The client demonstrates SHALL support for reading the MedicationAdministration resource type.
        )

        optional true

        def skip_message
          "Inferno did not receive any read requests for the `MedicationAdministration` resource type."
        end

        run do
          requests = load_tagged_requests(READ_MEDICATION_ADMINISTRATION_TAG)
          skip_if requests.blank?, skip_message
        end
      end
    end
  end
end
