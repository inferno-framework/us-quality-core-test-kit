# frozen_string_literal: true

module USQualityCoreTestKit
  module Client
    module USQualityCoreClientV100_BALLOT
      class ConditionEncounterDiagnosisClientReadTest < Inferno::Test
        id :us_quality_core_v100_ballot_condition_encounter_diagnosis_client_read_test

        title 'SHALL support read of Condition'

        description %(
          The client demonstrates SHALL support for reading the Condition resource type.
        )

        optional true

        def skip_message
          "Inferno did not receive any read requests for the `Condition` resource type."
        end

        run do
          requests = load_tagged_requests(READ_CONDITION_TAG)
          skip_if requests.blank?, skip_message
        end
      end
    end
  end
end
