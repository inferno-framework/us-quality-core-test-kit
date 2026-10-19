# frozen_string_literal: true

module USQualityCoreTestKit
  module Client
    module USQualityCoreClientV100_BALLOT
      class ImagingStudyClientReadTest < Inferno::Test
        id :us_quality_core_v100_ballot_imaging_study_client_read_test

        title 'SHALL support read of ImagingStudy'

        description %(
          The client demonstrates SHALL support for reading the ImagingStudy resource type.
        )

        optional true

        def skip_message
          "Inferno did not receive any read requests for the `ImagingStudy` resource type."
        end

        run do
          requests = load_tagged_requests(READ_IMAGING_STUDY_TAG)
          skip_if requests.blank?, skip_message
        end
      end
    end
  end
end
