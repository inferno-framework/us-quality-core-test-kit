module USQualityCoreTestKit
  module USQualityCoreV100_BALLOT
    class UsCoreDocumentreferenceDocumentReferenceCustodianTest < Inferno::Test
      id :us_quality_core_v100_ballot_us_core_documentreference_custodian_test

      title 'DocumentReference resources returned during previous tests have custodian'
      description %(
        This test verifies the organization responsible for the DocumentReference is present either in DocumentReference.custodian
        or accessible in the Provenance resource targeting the DocumentReference using Provenance.agent.who or Provenance.agent.onBehalfOf.
      )

      def scratch_resources
        scratch[:us_core_documentreference_resources] ||= {}
      end

      def scratch_provenance_resources
        scratch[:provenance_resources] ||= {}
      end

      run do
        resources = scratch_resources[:all] || []
        provenances = scratch_provenance_resources[:all] || []

        skip_if resources.blank?,
                'No DocumentReference resources appear to be available. ' \
                'Please use patients with more information.'

        resources.each do |docref|
          has_custodian = docref.custodian.present?

          if provenances.present?
            has_agent = provenances.any? do |provenance|
              has_target = provenance.target.any? do |target|
                target.reference&.end_with?("DocumentReference/#{docref.id}")
              end
              has_agent = provenance.agent.any? { |agent| agent.who.present? || agent.onBehalfOf.present? }

              has_target && has_agent
            end
          end

          unless has_custodian || has_agent
            add_message(
              'error',
              "DocumentReference/#{docref.id} does not have DocumentReference.custodian, " \
                'Provenance.agent.who, nor Provenance.agent.onBehalfOf'
            )
          end
        end

        assert messages.blank?,
               'Resource does not have DocumentReference.custodian, Provenance.agent.who, nor Provenance.agent.onBehalfOf'
      end
    end
  end
end
