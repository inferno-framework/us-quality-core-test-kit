# frozen_string_literal: true

module USQualityCoreTestKit
  module Client
    module USQualityCoreClientV050
      class GoalClientReadTest < Inferno::Test
        id :us_quality_core_v050_goal_client_read_test

        title 'SHALL support read of Goal'

        description %(
          The client demonstrates SHALL support for reading the Goal resource type.
        )

        optional true

        def skip_message
          "Inferno did not receive any read requests for the `Goal` resource type."
        end

        run do
          requests = load_tagged_requests(READ_GOAL_TAG)
          skip_if requests.blank?, skip_message
        end
      end
    end
  end
end
