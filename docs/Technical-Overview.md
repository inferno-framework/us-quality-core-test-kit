This technical overview orients developers to the design of the US Quality Core
Test Kit. Prior to reviewing this document, developers should be familiar with
the [US Quality Core Implementation Guide](https://fhir.org/guides/onc/us-quality-core/),
using this test kit, and building tests with the [Inferno
Framework](https://inferno-framework.github.io).

## Test Design Principles and Features

The tests in this repository are designed around these principles:

* Match the IG conformance scope: tests should target the in-scope USCDI+
  Quality V1 requirements identified by the IG, not every inherited artifact in
  the package.
* Limit extraneous constraints: tests should avoid imposing requirements that
  are not present in US Quality Core, US Core, FHIR, or the relevant
  CapabilityStatements.
* Leverage machine-readable content: profile, search, terminology, and
  CapabilityStatement content from the IG package drives generated tests where
  possible.
* Preserve narrative requirements: requirements described in IG guidance, such
  as USCDI+ Quality flags, modifier element handling, negation, and reference
  behavior, must be reflected even when they are not fully captured by generated
  code.
* Reuse US Core testing infrastructure: selected shared logic from the US Core
  Test Kit has been ported into the US Quality Core Test Kit namespace where
  practical.

Features of the server and client suites reflect these principles:

* Server systems provide their own representative data and patient IDs. The
  tests learn from returned data and use discovered resources for later checks.
* Client tests provide a simulated US Quality Core FHIR server and evaluate
  requests made by the client under test.
* Runtime validation uses the HL7 FHIR Validator with the US Quality Core IG
  package.
* Generated files are created from IG packages and should not be edited by hand.

## Project Source Code Structure

Below is the general structure of this test kit:

```text
root
+-- client-example-resources              Example resources loaded into the reference server for client testing
+-- config
| +-- presets                             Preset configurations for local and reference-server runs
+-- lib
| +-- us_quality_core_test_kit
| | +-- client
| | | +-- generator                       Client suite generator and templates
| | | +-- generated
| | | | +-- v0.5.0                        Generated client suite for US Quality Core v0.5.0
| | +-- generated
| | | +-- v0.5.0                          Generated server suite for US Quality Core v0.5.0
| | +-- generator                         Server suite generator and templates
| | +-- igs                               US Quality Core IG package archives and supplemental artifacts
+-- scripts                               Maintenance scripts
+-- spec                                  RSpec tests
```

Code within `generated` directories is produced by the generator and should not
be edited manually. Update generator code, templates, special cases, or IG input
artifacts instead, then regenerate.

## Related Systems and Dependencies

### US Core Test Kit

This test kit ports selected shared logic from
[`us_core_test_kit`](https://github.com/inferno-framework/us-core-test-kit)
into the `USQualityCoreTestKit` namespace and does not depend on the
`us_core_test_kit` gem at runtime. US Quality Core-specific behavior lives under
`lib/us_quality_core_test_kit/`.

### Inferno Reference Server

The [Inferno Reference Server](https://github.com/inferno-framework/inferno-reference-server)
is used for local client testing. The Docker setup mounts
`client-example-resources/` into the reference server and loads the resources
when the server database is empty.

The client suite proxies requests to the server configured by
`FHIR_REFERENCE_SERVER`. In the provided Docker configuration, this points to
the local reference server.

### HL7 FHIR Validator

Server resource validation is performed through the HL7 FHIR Validator service.
The validator is configured through `FHIR_RESOURCE_VALIDATOR_URL` and loads IG
packages from the test kit as needed.

### FHIRPath Service, Redis, and Database

The Docker setup also runs the FHIRPath service, Redis, and PostgreSQL services
used by Inferno and the bundled reference server.

## Testing Code Changes

### RSpec Tests

Run the repository test suite with:

```sh
bundle exec rake
```

These tests should pass before changes are merged. Coverage is focused on code
that is complex or likely to change, rather than complete line coverage.

### End-to-End Checks

After changes to generated tests, shared behavior, validation filters, or client
example data, run the relevant server and client suites in Inferno. The local
Docker setup provides an Inferno Reference Server loaded with US Quality Core
example data for client testing and can be useful for smoke testing server
behavior.

Local-reference-server demonstration limitations should be documented in the
relevant wiki page and kept current.

## Updating Generated Tests

The server and client tests are generated from IG packages in
`lib/us_quality_core_test_kit/igs`.

To add or update a US Quality Core IG package, place the IG package archive in
`lib/us_quality_core_test_kit/igs/` and name it with the pattern
`us_quality_core_v<version without dots>.tgz`. For example, US Quality Core
v0.5.0 is stored as `us_quality_core_v050.tgz`. Supplemental files for that
package belong in a same-named directory without the `.tgz` suffix, such as
`lib/us_quality_core_test_kit/igs/us_quality_core_v050/`.

Regenerate both suites with:

```sh
bundle exec rake usqualitycore:generate
```

To regenerate only one side:

```sh
bundle exec rake usqualitycore:generate mode=server
bundle exec rake usqualitycore:generate mode=client
```

The `us_quality_core:generate` task is also available as an equivalent alias.

After regeneration, inspect the generated suites and run relevant tests. Future
IG changes may require updates to generator special cases, extractors, or
templates before generated output matches the intended conformance scope.

## Updating Shared Component Tests

Generated files use shared component tests under `lib/us_quality_core_test_kit/`
and `lib/us_quality_core_test_kit/client/`. These files are not generated and
must be updated manually when shared behavior changes. Because they are reused
across profile groups, changes should be made carefully and covered by focused
tests where possible.

## Updating Client Example Data

The client suite uses the Inferno Reference Server and the resources in
`client-example-resources/` to return realistic US Quality Core data to clients
during testing. When generating or updating client suites for an IG version,
review the example bundle and update it as needed so the client tests have data
for the expected patient, reads, and searches.

Use `scripts/clean_bundle.rb` to keep the patient bundle ordering and formatting
consistent:

```sh
ruby scripts/clean_bundle.rb ./client-example-resources/us_quality_core_bundle_patient.json
```

The reference server only reloads these resources when its database is empty.
For the Docker setup, remove the backing volume before restarting Inferno if you
need changed resources to reload:

```sh
docker volume rm us-quality-core-test-kit_fhir-pgdata
```

## Overriding IG Machine-Readable Content

If a published IG package omits needed artifacts or contains content that must
be supplemented for generation, add supplemental files under a directory next
to the package archive. For example, supplemental files for
`lib/us_quality_core_test_kit/igs/us_quality_core_v050.tgz` belong in
`lib/us_quality_core_test_kit/igs/us_quality_core_v050/`.

The IG loader accepts JSON FHIR resources and nested `.tgz` packages from that
directory. Use this mechanism for supplemental profiles, SearchParameters,
ValueSets, CodeSystems, or dependency packages required by generation.

US Quality Core-specific generator behavior belongs in files such as:

* `lib/us_quality_core_test_kit/generator/special_cases.rb`
* `lib/us_quality_core_test_kit/generator/*_extractor.rb`
* `lib/us_quality_core_test_kit/generator/templates/*.erb`
* `lib/us_quality_core_test_kit/client/generator/*.rb`

## Overriding Validator Behavior

The HL7 Validator may report errors caused by validator behavior, terminology
service behavior, or upstream IG issues rather than by the system under test. In
those cases, server suites can filter specific messages.

General and version-specific validation message filters are defined by the
server suite generator and generated suite:

* `lib/us_quality_core_test_kit/generator/templates/suite.rb.erb`
* `lib/us_quality_core_test_kit/generator/suite_generator.rb`
* `lib/us_quality_core_test_kit/generated/v0.5.0/us_quality_core_test_suite.rb`

Prefer documenting the reason for each filter in code, including an upstream
issue reference when available.

## Unusual Implementation Details

The following areas deserve extra care during maintenance:

* Client tests proxy read and search requests through Inferno to the reference
  server and group requests by the bearer token supplied by the client.
* Some resources are gathered through references from other resources and may
  not behave well when their groups are run in isolation.
* USCDI+ Quality flags are separate from FHIR `mustSupport: true` and must be
  treated according to the IG's Must Support guidance.
* Validation filters should remain narrow and tied to specific known issues.
