# frozen_string_literal: true

module USQualityCoreTestKit
  module Client
    module USQualityCoreClientV050
      class OrganizationClientReadTest < Inferno::Test
        id :us_quality_core_v050_organization_client_read_test

        title 'SHALL support read of Organization'

        description %(
          The client demonstrates SHALL support for reading the Organization resource type.
        )

        optional false

        def skip_message
          "Inferno did not receive any read requests for the `Organization` resource type."
        end

        run do
          requests = load_tagged_requests(READ_ORGANIZATION_TAG)
          skip_if requests.blank?, skip_message
        end
      end
    end
  end
end
