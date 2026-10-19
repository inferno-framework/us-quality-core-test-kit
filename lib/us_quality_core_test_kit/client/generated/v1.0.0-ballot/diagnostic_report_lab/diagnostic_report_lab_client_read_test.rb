# frozen_string_literal: true

module USQualityCoreTestKit
  module Client
    module USQualityCoreClientV100_BALLOT
      class DiagnosticReportLabClientReadTest < Inferno::Test
        id :us_quality_core_v100_ballot_diagnostic_report_lab_client_read_test

        title 'SHALL support read of DiagnosticReport'

        description %(
          The client demonstrates SHALL support for reading the DiagnosticReport resource type.
        )

        optional true

        def skip_message
          "Inferno did not receive any read requests for the `DiagnosticReport` resource type."
        end

        run do
          requests = load_tagged_requests(READ_DIAGNOSTIC_REPORT_TAG)
          skip_if requests.blank?, skip_message
        end
      end
    end
  end
end
