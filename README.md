# US Quality Core Test Kit

The **US Quality Core Test Kit** validates the conformance of server and client
implementations to the US Quality Core Implementation Guide. The test kit
includes server and client suites for evaluating systems against the guide's conformance scope.

## Supported Implementation Guide Versions

- [2026 US Quality Core Implementation Guide v0.5.0](https://fhir.org/guides/onc/us-quality-core/) (USCDI+ Quality V1)
- [US Quality Core Implementation Guide v1.0.0-ballot](http://hl7.org/fhir/us/quality-core/1.0.0-202609-ballot/en) (Draft USCDI+ Quality V2)

For additional details on the tests, including their scope, usage, and local
demonstration notes, see the
[US Quality Core Test Kit documentation](https://github.com/inferno-framework/us-quality-core-test-kit/wiki).

## Getting Started

The quickest way to run this test kit locally is with
[Docker](https://www.docker.com/).

- Install Docker
- Clone or download this repository
- Open a terminal in the test kit directory
- Run `./setup.sh` to download necessary dependencies
- Run `./run.sh` to start the application
- Navigate to `http://localhost`

Detailed step-by-step instructions for running the tests can be found in the
wiki:

- [Preset Walkthrough](https://github.com/inferno-framework/us-quality-core-test-kit/wiki/Preset-Walkthrough)
- [Server Suite Overview](https://github.com/inferno-framework/us-quality-core-test-kit/wiki/Overview-Server)
- [Client Suite Overview](https://github.com/inferno-framework/us-quality-core-test-kit/wiki/Overview-Client)

When using a local Inferno Reference Server to test the v1.0.0-ballot client
suite, select the `inferno_reference_server_100_ballot` preset. The matching
[v1.0.0-ballot Postman collection](https://raw.githubusercontent.com/inferno-framework/us-quality-core-test-kit/main/lib/us_quality_core_test_kit/client/generated/v1.0.0-ballot/example_client_v100_ballot.postman_collection.json)
contains example client requests for that suite.

The Docker setup starts an [Inferno Reference
Server](https://github.com/inferno-framework/inferno-reference-server) loaded
from `client-example-resources/` when the reference server database is empty.
This supports local client testing and can also be useful for server-suite
development.

More information on using Inferno Test Kits is available on the [Inferno
Framework documentation site](https://inferno-framework.github.io/docs).

### Multi-user Installations

The default configuration of this test kit uses SQLite for data persistence and
is optimized for running on a local machine with a single user. For
installations on shared servers that may have multiple tests running
simultaneously, please [configure the installation to use
PostgreSQL](https://inferno-framework.github.io/docs/deployment/database.html#postgresql-with-docker)
to ensure stability in this type of environment.

## Contributing to this Test Kit

Developers contributing to this test kit should be familiar with
[authoring Inferno Framework test suites](https://inferno-framework.github.io/docs/writing-tests/).
Additional design and maintenance information is available in the
[Technical Overview](https://github.com/inferno-framework/us-quality-core-test-kit/wiki/Technical-Overview).

## Providing Feedback and Reporting Issues

We welcome feedback on the tests, including validation logic, requirements
coverage, user experience, and documentation.

Please report problems or suggestions in the
[issues section](https://github.com/inferno-framework/us-quality-core-test-kit/issues)
of this repository. The team may also be reached in the
[#inferno Zulip stream](https://chat.fhir.org/#narrow/stream/179309-inferno).

## License

Licensed under the Apache License, Version 2.0. See [LICENSE](LICENSE).

## Trademark Notice

HL7, FHIR and the FHIR [FLAME DESIGN] are the registered trademarks of Health
Level Seven International and their use does not constitute endorsement by HL7.
