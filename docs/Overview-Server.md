The US Quality Core Test Kit provides server testing for the [2026 US Quality
Core Implementation Guide v0.5.0](https://fhir.org/guides/onc/us-quality-core/).
The server tests simulate a realistic client retrieving in-scope USCDI+ Quality
V1 data through the FHIR RESTful API interactions required by the IG.

The US Quality Core Server Suite is intended to:

* Verify a server's support for the IG's conformance scope, including profiles
  with USCDI+ Quality-flagged elements and inherited US Core MustSupport
  elements.
* Verify required `read`, `search-type`, search parameter, and combined search
  behavior from the [US Quality Core Server
  CapabilityStatement](https://fhir.org/guides/onc/us-quality-core/CapabilityStatement-us-quality-core-server.html).
* Provide reusable tests for other Inferno test kits that need to check US
  Quality Core behavior.

This guide targets users who want to run the US Quality Core Test Kit outside
the context of another Implementation Guide or certification criterion.

## Testing Options

Users of the server suite provide:

* The FHIR endpoint URL for the server under test.
* Optional OAuth credentials if the endpoint requires authorization.
* One or more patient IDs whose records are expected to demonstrate support for
  the in-scope USCDI+ Quality V1 data elements.

The current generated server suite targets US Quality Core v0.5.0.

## Test Prerequisites

Servers do not need to load a fixed data set to run these tests. However, the
server under test must expose representative data for the supplied patient IDs.
The selected records should include enough in-scope USCDI+ Quality V1 data to
demonstrate support for the profile elements and searches being tested.

The repository includes a Docker-based Inferno Reference Server loaded from
`client-example-resources/` for local client testing and development. That
reference server can also be useful as a known data source while developing or
debugging the server tests.

## Conformance Criteria

The test kit scope is intended to match the [US Quality Core conformance
requirements](https://fhir.org/guides/onc/us-quality-core/general-requirements.html).
The IG includes inherited QI-Core-derived artifacts to ease adoption, but the
server suite focuses on the conformance requirements for in-scope USCDI+ Quality
V1 data. IG artifacts outside that conformance scope are not the primary target
of this test kit.

Testers may run the entire suite or selected profile groups. A selected group
passes when the server demonstrates the required API behavior and returns
resources that satisfy the relevant profile, terminology, reference, and element
requirements.

## Test Groups

The server suite is organized under one high-level group.

### US Quality Core FHIR API

This group contains the server tests for the US Quality Core FHIR API. The
tests are principally organized by profile or resource type and include:

* Search tests for required search parameters and required search parameter
  combinations.
* Read tests for resources discovered during search.
* Provenance `_revinclude` search tests where applicable.
* Profile validation using the HL7 FHIR Validator and the US Quality Core IG
  package.
* Checks for USCDI+ Quality-flagged elements, inherited US Core MustSupport
  elements, terminology bindings, and mandatory elements.
* Reference resolution checks for supported references.

Users may provide a single patient ID or a comma-separated list of patient IDs.
Providing multiple patient IDs can help the tests evaluate required elements
across a broader set of resources.

Some profile groups depend on resources discovered through references from other
groups. When possible, run the full US Quality Core FHIR API group rather than
isolating non-patient-scoped groups.
