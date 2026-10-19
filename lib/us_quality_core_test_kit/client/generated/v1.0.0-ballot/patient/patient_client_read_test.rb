# frozen_string_literal: true

module USQualityCoreTestKit
  module Client
    module USQualityCoreClientV100_BALLOT
      class PatientClientReadTest < Inferno::Test
        id :us_quality_core_v100_ballot_patient_client_read_test

        title 'SHALL support read of Patient'

        description %(
          The client demonstrates SHALL support for reading the Patient resource type.
        )

        optional false

        def skip_message
          "Inferno did not receive any read requests for the `Patient` resource type."
        end

        run do
          requests = load_tagged_requests(READ_PATIENT_TAG)
          skip_if requests.blank?, skip_message
        end
      end
    end
  end
end
