require_relative '../../../must_support_test'

module USQualityCoreTestKit
  module USQualityCoreV100
    class DiagnosticReportNoteMustSupportTest < Inferno::Test
      include USQualityCoreTestKit::MustSupportTest

      title 'All must support elements are provided in the DiagnosticReport resources returned'

      description %(
        This test will look through the DiagnosticReport resources
        found previously for the following Must Support and USCDI-flagged elements:

        * DiagnosticReport.category
        * DiagnosticReport.category:us-core
        * DiagnosticReport.code
        * DiagnosticReport.effectiveDateTime
        * DiagnosticReport.encounter
        * DiagnosticReport.issued
        * DiagnosticReport.performer
        * DiagnosticReport.presentedForm
        * DiagnosticReport.result
        * DiagnosticReport.resultsInterpreter
        * DiagnosticReport.status
        * DiagnosticReport.subject
      )

      id :us_quality_core_v100_diagnostic_report_note_must_support_test

      def resource_type
        'DiagnosticReport'
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:diagnostic_report_note_resources] ||= {}
      end

      run do
        perform_must_support_test(all_scratch_resources)
      end
    end
  end
end
