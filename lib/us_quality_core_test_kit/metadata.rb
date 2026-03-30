# frozen_string_literal: true

require_relative 'version'

module USQualityCoreTestKit
  class Metadata < Inferno::TestKit
    id :us_quality_core_test_kit

    title 'US Quality Core Test Kit'

    description <<~DESCRIPTION
      The US Quality Core Test Kit validates the conformance of server and client
      implementations to an enhanced version of the US Quality Core Implementation Guide
      that includes USCDI+ Quality guidance and more concrete requirements on
      support for the standard RESTful FHIR API.  The current focus is US Quality Core
      STU 6.0.0, which aligns with US Core STU v6.1.0 and FHIR R4 (4.0.1).
      While US Quality Core derives from and extends US Core, the test kit only verifies
      US-Quality-Core-specific requirements.
      <!-- break -->

      This test kit is open source and freely available for use or adoption by
      the health IT community including EHR vendors, health app developers,
      quality measure developers, payers, and testing labs. It
      is built using the Inferno Framework. The Inferno Framework is designed
      for reuse and aims to make it easier to build test kits for any FHIR-based
      data exchange, including quality measurement and clinical decision
      support.

      ## Status

      These tests are a DRAFT intended to allow US Quality Core implementers to perform
      preliminary checks of their implementations against US Quality Core and USCDI+ Quality
      requirements and provide feedback on the tests. Future versions of these
      tests may validate other requirements and may change how these are tested.

      ## Server Suite

      The US Quality Core Server Suite verifies conformance with US Quality Core and the aligned
      US Core requirements for the resources an implementation exchanges. They
      currently verify the following:

      * Support for US Quality Core profiles
      * Support for FHIR read and search operations for relevant FHIR resources
      * Support for "Must Support" elements
      * Support for USCDI+ Quality elements
      * Terminology validation using tx.fhir.org

      ## Client suites

      The US Quality Core Client suites verify a client's capability to request,
      interpret, and use data conforming to US Quality Core requirements. They currently
      verify the following:

      * Ability to request data on all US Quality Core profiles supported by the server
      * Support for read and search interaction requests

      ## Repository

      The [US Quality Core Test Kit](https://github.com/inferno-framework/TODO)
      repository provides all source code for this test kit.


      ## Providing feedback and reporting issues

      We welcome feedback on the tests, including but not limited to the following areas:

      * Validation logic, such as potential bugs, lax checks, and unexpected failures
      * Requirements coverage, such as missed US-Quality-Core-specific requirements
      * User experience, such as confusing or missing information in the test UI

      Please report any issues with this set of tests in the issues section of the repository.
    DESCRIPTION

    suite_ids %i[
      us_quality_core_v010
      us_quality_core_client_v010
    ]

    tags ['US-Quality-Core']

    version VERSION

    last_updated LAST_UPDATED

    maturity 'Low'

    authors ['MITRE']
  end
end
