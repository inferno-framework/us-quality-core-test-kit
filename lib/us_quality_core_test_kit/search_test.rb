# frozen_string_literal: true

require 'us_core_test_kit/search_test'

module USQualityCoreTestKit
  module SearchTest
    include USCoreTestKit::SearchTest
    extend USCoreTestKit::SearchTest

    def patient_id_param?(name)
      name == 'patient' || name == 'subject' || (name == '_id' && resource_type == 'Patient')
    end

    def filter_devices(resources)
      resources # NOOP for US Quality Core
    end

    def no_resources_skip_message(resource_type = self.resource_type)
      "No #{resource_type} resources appear to be available. Please use patients with more information"
    end
  end
end
