# frozen_string_literal: true

require 'inferno'

require_relative 'us_quality_core_test_kit/metadata'

# Server Suites
require_relative 'us_quality_core_test_kit/generated/v0.5.0/us_quality_core_test_suite'
require_relative 'us_quality_core_test_kit/generated/v1.0.0/us_quality_core_test_suite'

# Client Suites
require_relative 'us_quality_core_test_kit/client/generated/v0.5.0/us_quality_core_client_test_suite'
require_relative 'us_quality_core_test_kit/client/generated/v1.0.0/us_quality_core_client_test_suite'
