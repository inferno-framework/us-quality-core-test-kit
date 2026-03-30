# US Quality Core Test Kit

The US Quality Core Test Kit validates the conformance of server and client
implementations to an enhanced version of the US Quality Core Implementation Guide that
includes USCDI+ Quality guidance and more concrete requirements on support for
the standard RESTful FHIR API. The current focus is US Quality Core v0.1.0, which
aligns with US Core STU v6.1.0 and FHIR R4 (4.0.1). While US Quality Core derives from
and extends US Core, the test kit only verifies US Quality Core specific requirements.

This test kit provides testing for US Quality Core clients and servers.

## Getting Started

The quickest way to run this test kit locally is with [Docker](https://www.docker.com/).

- Install Docker
- Clone this repository
- Run `./setup.sh` within the test kit directory to download necessary dependencies
- Run `./run.sh` within the test kit directory to start the application
- Navigate to `http://localhost`

### Inferno US Core R4 Reference Server

The client tests require an instance of the [Inferno Reference
Server](https://github.com/inferno-framework/inferno-reference-server) to be
running so that realistic content can be served to the client. The reference
server should be loaded with US Quality Core example data, which is included in the
`./client-example-resources` directory.

The provided docker-compose file runs the reference server as a background service,
which will be automatically loaded with the necessary data if there are no resources
yet loaded.

To clear the resources of the file to force a reload, run `docker volume rm
us-quality-core-test-kit_fhir-pgdata`. See the [Inferno Reference
Server](https://github.com/inferno-framework/inferno-reference-server) for more
information.

## Contributing to this Test Kit

Developers contributing to this test kit should be familiar with
[authoring Inferno Framework test suites](https://inferno-framework.github.io/docs/writing-tests/).

This test kit follows much of the same approach taken by the
[US Core Test Kit](https://github.com/inferno-framework/us-core-test-kit/tree/main)
for generating client and server test suites. At the moment the US Quality Core generators
extend and modify the US Core generators where needed, however this may change
in the future depending on evolving requirements.

### Source Code Structure

The general layout of the source code for this test kit is as follows:

```
.
+-- client-example-resources                            # Example resources used for the client test suite
+-- lib
│   +-- us_quality_core_test_kit
│       +-- client                                      # Client suite source code
│       │   +-- generator                               # Source code for generating client test suites
│       │   │   +-- templates                           # ERB templates used by the client generator
│       │   +-- generated                               # Generated client suites by IG version
│       │   │   +-- v0.1.0
│       │   │       +-- us_quality_core_test_suite.rb   # Client test suite for this IG version
│       │   +-- metadata                                # Content used to help simulate a FHIR server for client testing
│       +-- generator                                   # Source code for generating server test suites
│       │   +-- templates                               # ERB templates used by the server generator
│       +-- generated                                   # Generated server suites by IG version
│       │   +-- v0.1.0
│       │       +-- us_quality_core_test_suite.rb       # Server test suite for this IG version
│       +-- igs                                         # US Quality Core IG packages
│       +-- us_quality_core_test_kit.rb                 # References all generated test suites
+-- scripts                                             # Helpful scripts for testing & maintaining the test kit
```

### Making Changes

Do not manually update files in either `generated` directory, as they
will be overwritten the next time the generators are run. Instead, changes should
be made to the relevant generators and/or templates.

To (re)generate client and server test suites for every version of the IG found
in `/lib/us_quality_core_test_kit/igs`, run:

```sh
bundle exec rake usqualitycore:generate
```

#### Adding New US Quality Core IG Versions

Place the IG Package archive (`package.tgz`) in the `lib/us_quality_core_test_kit/igs/` directory. Rename
the file such that it corresponds to the following pattern: `us_quality_core_v<version without dots>.tgz`
(e.g. `us_quality_core_v010.tgz`). Re-run the generator rake task, and inspect the results. Depending on
future changes to the IG, changes may need to be made to the
`lib/us_quality_core_test_kit/generator/special_cases.rb` source file. See that file for more details.

#### Client Suite Test Data

The [Inferno Reference Server](https://github.com/inferno-framework/inferno-reference-server)
backed client tests require valid US Quality Core data such that realistic content can be served to
the client during testing. When generating new client test suites for new versions of the
US Quality Core IG, this bundle of test data (location in the `./client-example-resources` directory)
should be updated.

There is a script available under the `./scripts` directory called `clean_bundle.rb`, meant
to help keep updates to this bundle as consistent as possible. You use it, run:

```sh
ruby scripts/clean_bundle.rb ./client-example-resources/us-quality-core-bundle.json
```

## Trademark Notice

HL7, FHIR and the FHIR [FLAME DESIGN] are the registered trademarks of Health
Level Seven International and their use does not constitute endorsement by HL7.
