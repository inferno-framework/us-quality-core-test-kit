# frozen_string_literal: true

module USQualityCoreTestKit
  module Client
    module USQualityCoreClientV050
      class ImagingStudyPatientClientSearchTest < Inferno::Test
        include TestHelper

        id :us_quality_core_v050_imaging_study_patient_client_search_test

        title 'SHALL support patient search of ImagingStudy'

        description %(
          The client demonstrates SHALL support for searching patient on ImagingStudy.
        )

        optional false

        def required_params
          ["patient"]
        end

        def skip_message
          "Inferno did not receive any search requests for the `ImagingStudy` resource type."
        end

        def failure_message
          "Inferno did not receive the expected search made for the `ImagingStudy` resource type with required search parameters: `#{required_params.join(' + ')}`."
        end

        run do
          requests = load_tagged_requests(SEARCH_IMAGING_STUDY_TAG)
          skip_if requests.blank?, skip_message

          requests_with_params = filter_requests_by_search_parameters(requests, required_params)
          assert requests_with_params.any?, failure_message
        end
      end
    end
  end
end
