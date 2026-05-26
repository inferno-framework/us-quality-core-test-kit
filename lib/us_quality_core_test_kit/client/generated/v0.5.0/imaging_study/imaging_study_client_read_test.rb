# frozen_string_literal: true

module USQualityCoreTestKit
  module Client
    module USQualityCoreClientV050
      class ImagingStudyClientReadTest < Inferno::Test
        include TestHelper

        id :us_quality_core_v050_imaging_study_client_read_test

        title 'SHALL support read of ImagingStudy'

        description %(
          The client demonstrates SHALL support for reading ImagingStudy.
        )

        def skip_message
          "Inferno did not receive any read requests for the `ImagingStudy` resource type."
        end

        def failure_message
          "Inferno did not receive the expected read request for the target instance of the US Quality Core ImagingStudy: `ImagingStudy/usqualitycore-imaging-study`."
        end

        run do
          requests = load_tagged_requests(READ_IMAGING_STUDY_TAG)
          skip_if requests.blank?, skip_message

          requests_for_id = filter_requests_by_resource_id(requests, 'usqualitycore-imaging-study')
          assert requests_for_id.any?, failure_message
        end
      end
    end
  end
end
