The US Quality Core Test Kit includes a client suite for the [2026 US Quality
Core Implementation Guide v0.5.0](https://fhir.org/guides/onc/us-quality-core/).
The client suite simulates a conformant US Quality Core FHIR server and records
client requests so Inferno can evaluate whether the client can retrieve
in-scope USCDI+ Quality V1 data through the required FHIR RESTful API
interactions.

The US Quality Core Client Suite is intended to:

* Provide general testing for clients that access data from US Quality Core
  servers.
* Verify that a client can request profile-conformant data from Inferno's
  simulated server.
* Verify required read and search requests described by the [US Quality Core
  CapabilityStatements](https://fhir.org/guides/onc/us-quality-core/capability-statements.html).

## Testing Options

During the Client Access step, Inferno generates a unique access token for the
run. The client must send
requests to the FHIR base URL displayed by Inferno and include:

```text
Authorization: Bearer <Access Token>
```

If the client configuration asks for an access token, enter only the generated
token value shown by Inferno. Do not include the `Bearer` scheme unless
configuring the full HTTP header directly.

The current generated client suite targets US Quality Core v0.5.0.

The repository includes a generated Postman collection at
`lib/us_quality_core_test_kit/client/generated/v0.5.0/example_client_v050.postman_collection.json`.
This collection can be used as a demonstration client. Its `base_url` variable
defaults to the developer-mode client-suite endpoint:

```text
http://localhost:4567/custom/us_quality_core_client_v050/fhir
```

If using the Docker setup through the non-developer `http://localhost`
entrypoint, update `base_url` to
`http://localhost/custom/us_quality_core_client_v050/fhir`. For hosted Inferno
runs, update `base_url` to the FHIR base URL shown by the Client Access step.
The collection's `access_token` variable must match the generated access token
shown by Inferno for the current Client Access run. Update the imported
collection variable to the generated token before running the collection.

## Test Prerequisites

The client suite requires an Inferno Reference Server containing US Quality Core
example data. In the Docker setup, this reference server is started by
`docker-compose.yml` and loaded from the resources in `client-example-resources/`.
Inferno proxies client requests to the reference server configured by the
`FHIR_REFERENCE_SERVER` environment variable.

Testers may need to pre-register or otherwise identify the target patient in the
client system:

* **Resource ID**: `usqualitycore-patient`
* **Name**: Peter James Chalmers Jr
* **Date of Birth**: 1974-12-25
* **Gender**: male
* **Identifier**: `12345` with system `urn:oid:1.2.36.146.595.217.0.1`

The reference server also contains related clinical data used by the generated
client profile groups.

## Conformance Criteria

The test kit scope is intended to match the [US Quality Core conformance
requirements](https://fhir.org/guides/onc/us-quality-core/general-requirements.html)
and the IG's [USCDI+ Quality mapping](https://fhir.org/guides/onc/us-quality-core/uscdiquality.html).
The client suite evaluates access to in-scope USCDI+ Quality V1 data, not every
artifact included in the IG package.

The client tests evaluate requests received during the latest Client Access run.
If the client makes requests for a resource type, Inferno evaluates the profile
groups for that resource type. If the client makes no requests for a resource
type, support for that resource type is not evaluated unless required by the
suite logic.

## Test Groups

The client suite is organized into the following high-level group.

### Read & Search

This group contains the client tests. Execution has two phases:

* Inferno waits while the client makes requests to the simulated US Quality Core
  FHIR server.
* Once the tester indicates the client is done, Inferno evaluates the recorded
  requests against the read and search requirements for each profile group.

The Read & Search group includes a Client Access subgroup followed by generated
profile groups. Testers can run the full Read & Search group or run Client
Access followed by selected profile groups to evaluate a smaller set of client
requests.

The generated Postman collection can be used as a concrete example of the
expected request patterns.
