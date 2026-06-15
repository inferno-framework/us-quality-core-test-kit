# US Quality Core Test Kit

The **US Quality Core Test Kit** validates the conformance of server and client
implementations to the [2026 US Quality Core Implementation Guide
v0.5.0](https://fhir.org/guides/onc/us-quality-core/). The test kit includes
server and client suites focused on the IG's conformance scope for USCDI+
Quality V1 data.

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
