# frozen_string_literal: true

module USQualityCoreTestKit
  module Client
    module USQualityCoreClientV100_BALLOT
      class TaskdoneClientReadTest < Inferno::Test
        id :us_quality_core_v100_ballot_taskdone_client_read_test

        title 'SHALL support read of Task'

        description %(
          The client demonstrates SHALL support for reading the Task resource type.
        )

        optional true

        def skip_message
          "Inferno did not receive any read requests for the `Task` resource type."
        end

        run do
          requests = load_tagged_requests(READ_TASK_TAG)
          skip_if requests.blank?, skip_message
        end
      end
    end
  end
end
