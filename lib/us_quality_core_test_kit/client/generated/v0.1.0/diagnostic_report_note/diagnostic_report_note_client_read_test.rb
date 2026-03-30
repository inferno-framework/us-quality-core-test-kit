# frozen_string_literal: true

module USQualityCoreTestKit
  module Client
    module USQualityCoreClientV010
      class DiagnosticReportNoteClientReadTest < Inferno::Test
        include TestHelper

        id :us_quality_core_v010_diagnostic_report_note_client_read_test

        title 'SHALL support read of DiagnosticReportNote'

        description %(
          The client demonstrates SHALL support for reading DiagnosticReportNote.
        )

        def skip_message
          "Inferno did not receive any read requests for the `DiagnosticReport` resource type."
        end

        def failure_message
          "Inferno did not receive the expected read request for the target instance of the US Quality Core DiagnosticReport Profile for Report and Note Exchange: `DiagnosticReport/us-quality-core-test-kit-diagnostic-report-note`."
        end

        run do
          requests = load_tagged_requests(READ_DIAGNOSTIC_REPORT_TAG)
          skip_if requests.blank?, skip_message

          requests_for_id = filter_requests_by_resource_id(requests, 'us-quality-core-test-kit-diagnostic-report-note')
          assert requests_for_id.any?, failure_message
        end
      end
    end
  end
end
