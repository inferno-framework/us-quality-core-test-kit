# frozen_string_literal: true

require_relative 'version'

module USQualityCoreTestKit
  class Metadata < Inferno::TestKit
    id :us_quality_core_test_kit

    title 'US Quality Core Test Kit'

    description <<~DESCRIPTION
      The US Quality Core Test Kit validates server and client implementations
      against the [US Quality Core Implementation Guide
      v0.5.0](https://fhir.org/guides/onc/us-quality-core/).

      <!-- break -->

      This test kit is [open source](https://github.com/inferno-framework/us-quality-core-test-kit)
      and freely available for use or adoption by the health IT community,
      including EHR vendors, health app developers, quality measure developers,
      payers, and testing labs. It is built using the [Inferno
      Framework](https://inferno-framework.github.io), which is designed for
      reuse and aims to make it easier to build test kits for FHIR-based data
      exchange, including quality measurement and clinical decision support.

      ## Status

      These tests are a DRAFT intended to allow US Quality Core implementers to
      perform preliminary checks of their implementations against the
      [US Quality Core conformance requirements](https://fhir.org/guides/onc/us-quality-core/general-requirements.html)
      and provide feedback on the tests. Future versions may validate
      additional requirements or change how these requirements are tested.

      ## Scope

      The scope of this test kit is intended to match the conformance scope
      defined by US Quality Core v0.5.0. The IG is derived from QI-Core STU 6
      and includes inherited profiles to ease adoption, but its conformance
      requirements are focused on USCDI+ Quality V1 data. The IG's
      [USCDI+ Quality mapping](https://fhir.org/guides/onc/us-quality-core/uscdiquality.html)
      identifies the in-scope V1 data elements. For conformance,
      implementations are expected to support profile types with at least one
      USCDI+ Quality-flagged data element, all USCDI+ Quality-flagged elements,
      and inherited US Core MustSupport elements.

      ## Server Suite

      The US Quality Core Server Suite verifies support for the IG's in-scope
      profile, element, and API requirements. It includes:

      * Support for in-scope US Quality Core and US Core profiles that implement USCDI+ Quality V1 data elements
      * Support for USCDI+ Quality-flagged elements and inherited US Core MustSupport elements
      * Support for FHIR read and search operations required by the [US Quality Core Server CapabilityStatement](https://fhir.org/guides/onc/us-quality-core/CapabilityStatement-us-quality-core-server.html)
      * Support for base FHIR requirements and terminology bindings, with validation performed by the HL7 FHIR Validator using tx.fhir.org

      ## Client Suite

      The US Quality Core Client Suite verifies a client's ability to ingest
      in-scope USCDI+ Quality data from a conformant US Quality Core server over
      the standard FHIR API. It includes evaluating:

      * The ability to request profile-conformant data from Inferno's simulated US Quality Core server
      * Support for read and search interaction requests described by the [US Quality Core CapabilityStatements](https://fhir.org/guides/onc/us-quality-core/capability-statements.html)

      ## Repository

      The [US Quality Core Test Kit](https://github.com/inferno-framework/us-quality-core-test-kit)
      repository contains the source code for this test kit.


      ## Providing Feedback and Reporting Issues

      We welcome feedback on the tests, including but not limited to the
      following areas:

      * Validation logic, such as potential bugs, lax checks, and unexpected failures
      * Requirements coverage, such as missed US Quality Core requirements
      * User experience, such as confusing or missing information in the test UI

      Please report issues in the [repository's
      issues](https://github.com/inferno-framework/us-quality-core-test-kit/issues)
      section.

    DESCRIPTION

    suite_ids %i[
      us_quality_core_v050
      us_quality_core_client_v050
    ]

    tags ['US Quality Core']

    version VERSION

    last_updated LAST_UPDATED

    maturity 'Low'

    authors ['MITRE']
  end
end
