# US Quality Core Test Kit Documentation

The **US Quality Core Test Kit** is an automated conformance testing tool for
servers and clients implementing the [2026 US Quality Core Implementation
Guide v0.5.0](https://fhir.org/guides/onc/us-quality-core/) and the [US Quality
Core Implementation Guide v1.0.0-ballot](http://hl7.org/fhir/us/quality-core/1.0.0-202609-ballot/en).
It tests each guide's conformance scope—USCDI+ Quality V1 for v0.5.0 and Draft
USCDI+ Quality V2 for v1.0.0-ballot—including in-scope profiles, USCDI+
Quality-flagged elements, inherited US Core MustSupport elements, and FHIR
RESTful API requirements from the US Quality Core CapabilityStatements.

The following documentation describes how to use and contribute to this test
kit.

## Using this Test Kit

* [Getting Started](https://github.com/inferno-framework/us-quality-core-test-kit/?tab=readme-ov-file#getting-started):
  Installation instructions for this test kit.
* Test Suite Overviews: Overviews of the two kinds of test suites in this test
  kit and their tests.
  * [Server Suite Overview](https://github.com/inferno-framework/us-quality-core-test-kit/wiki/Overview-Server)
  * [Client Suite Overview](https://github.com/inferno-framework/us-quality-core-test-kit/wiki/Overview-Client)
* [Preset Walkthrough](https://github.com/inferno-framework/us-quality-core-test-kit/wiki/Preset-Walkthrough):
  Step-by-step local walkthroughs using the included presets and reference
  server.

## Resources

* [Example Postman Collection](https://raw.githubusercontent.com/inferno-framework/us-quality-core-test-kit/main/lib/us_quality_core_test_kit/client/generated/v0.5.0/example_client_v050.postman_collection.json):
  Demonstration client requests for the v0.5.0 client suite.
* [v1.0.0-ballot Postman Collection](https://raw.githubusercontent.com/inferno-framework/us-quality-core-test-kit/main/lib/us_quality_core_test_kit/client/generated/v1.0.0-ballot/example_client_v100_ballot.postman_collection.json):
  Demonstration client requests for the v1.0.0-ballot client suite.
* `inferno_reference_server_100_ballot` preset:
  Preset for testing the v1.0.0-ballot client suite against the local Inferno
  Reference Server.
* [Example Patient Bundle](https://raw.githubusercontent.com/inferno-framework/us-quality-core-test-kit/main/client-example-resources/us_quality_core_bundle_patient.json):
  Example US Quality Core resources loaded into the local Inferno Reference
  Server.

## Contributing to this Test Kit

Developers contributing to this test kit should be familiar with
[authoring Inferno Framework test suites](https://inferno-framework.github.io/docs/writing-tests/).
The following guides provide additional information about the design and
implementation of this test kit:

* [Technical Overview](https://github.com/inferno-framework/us-quality-core-test-kit/wiki/Technical-Overview):
  An overview of the technical design of this test kit.

## Support

For questions or issues with this Test Kit, reach out to the Inferno team on
the [#Inferno FHIR Zulip channel](https://chat.fhir.org/#narrow/stream/179309-inferno).

Report bugs or provide suggestions in
[GitHub Issues](https://github.com/inferno-framework/us-quality-core-test-kit/issues).
