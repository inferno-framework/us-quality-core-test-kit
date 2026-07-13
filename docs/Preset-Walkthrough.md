# Preset Walkthrough

This walkthrough shows how to exercise the US Quality Core suites using the
presets included in this repository. It is intended for local setup, smoke
testing, and demonstration. It is not a substitute for testing a real
implementation with representative production-like data.

## Start Inferno Locally

From the repository root:

```sh
./setup.sh
./run.sh
```

Open `http://localhost` after the containers start. The Docker setup starts
Inferno, the HL7 FHIR Validator service, the FHIRPath service, and an Inferno
Reference Server at:

```text
http://localhost:8080/reference-server/r4
```

The reference server is loaded from `client-example-resources/` when its
database is empty.

If you change the example resources and need the reference server to reload
them, stop the stack and remove the backing volume:

```sh
docker volume rm us-quality-core-test-kit_fhir-pgdata
```

Then restart with `./run.sh`.

## Server Suite Against the Inferno Reference Server

Use this path to run the server suite against the Inferno Reference Server.
The preset uses the reference server configured by `FHIR_REFERENCE_SERVER`,
falling back to the public Inferno Reference Server when the variable is not
set.

1. Start a new **US Quality Core Server v0.5.0** session.
2. Select the **Inferno Reference Server** preset from the preset dropdown in
   the upper left.
3. Confirm that the preset filled in:
   * **FHIR Endpoint**: the value configured by `FHIR_REFERENCE_SERVER`, or
     `https://inferno.healthit.gov/reference-server/r4` when it is not set
   * **OAuth Credentials access token**: `SAMPLE_TOKEN`
   * **Patient IDs**: `usqualitycore-patient`
4. Run the **US Quality Core FHIR API** group, or run selected profile groups
   under it.
5. Review failures, warnings, skips, and omissions in the Inferno results.

The reference-server data is intended to exercise the generated tests.

## Server Suite Against the Public US Core Reference Server

The **US Core-Only Reference Server** preset points to the public Inferno
Reference Server:

```text
https://inferno.healthit.gov/reference-server/r4
```

Use this preset only as a limited smoke test for behavior shared with US Core.
It is not expected to demonstrate full US Quality Core conformance because the
target server is not loaded with US Quality Core-specific data.

1. Start a new **US Quality Core Server v0.5.0** session.
2. Select the **US Core-Only Reference Server** preset.
3. Run selected groups that are useful for the question you are investigating.
4. Interpret failures in light of the preset's limited data scope.

## Client Suite With the Local Reference Server

The client suite does not currently need a saved preset. It simulates a US
Quality Core FHIR server inside Inferno and proxies data requests to the local
Inferno Reference Server configured by `FHIR_REFERENCE_SERVER`.

1. Make sure the Docker stack is running and the local reference server is
   available.
2. Start a new **US Quality Core Client v0.5.0** session.
3. Run the **Read & Search** group or its **Client Access** subgroup.
4. Inferno will generate a unique access token for this run.
5. Inferno will display a FHIR base URL under
   `/custom/us_quality_core_client_v050/fhir` and the access token for the run.
   Configure the client under test to use that URL.
6. Configure the client to send:

   ```text
   Authorization: Bearer <access token shown by Inferno>
   ```

   If the client configuration asks for an access token, enter only the token
   value, not the `Bearer` scheme. The bearer token must match the generated
   access token shown by Inferno so Inferno can associate requests with the
   current test run.
7. Configure or select the target patient:
   * **Resource ID**: `usqualitycore-patient`
   * **Name**: Peter James Chalmers Jr
   * **Date of Birth**: 1974-12-25
   * **Gender**: male
8. Trigger the client to request USCDI+ Quality data from Inferno's simulated
   FHIR server.
9. Return to Inferno and click the completion link in the **User Action
   Required** dialog.
10. Run the profile groups you want to evaluate, or run the full **Read &
    Search** group.

For a concrete request example, see the generated Postman collection:

```text
lib/us_quality_core_test_kit/client/generated/v0.5.0/example_client_v050.postman_collection.json
```

### Using the Generated Postman Collection

The Postman collection is a demonstration client for the client suite. It sends
the read and search requests that Inferno expects to observe during Client
Access. It is not a server-suite preset and it does not point at the public
Inferno Reference Server.

The collection includes two variables:

* `base_url`: the simulated US Quality Core FHIR server URL exposed by Inferno.
  The checked-in default is
  `http://localhost:4567/custom/us_quality_core_client_v050/fhir`, which
  matches the developer-mode Inferno server. If using the Docker setup through
  the non-developer `http://localhost` entrypoint, update this value to
  `http://localhost/custom/us_quality_core_client_v050/fhir`. If running
  against a hosted Inferno instance, set this to the FHIR base URL displayed by
  that Inferno Client Access step.
* `access_token`: the value Postman sends as
  `Authorization: Bearer <access_token>`. This must match the access token
  generated by Inferno for the current Client Access run.

To use the collection locally:

1. Import the collection into Postman.
2. Start the **US Quality Core Client v0.5.0** suite in Inferno.
3. Run **Read & Search** or **Client Access**.
4. When Inferno displays the Client Access instructions, set the collection
   `access_token` variable to the generated token value shown there.
5. Confirm that `base_url` matches the URL shown by Inferno.
6. Run the collection in Postman.
7. Return to Inferno and click the completion link in the **User Action
   Required** dialog.
8. Run the generated profile groups to evaluate the recorded Postman requests.

## Running Server and Client Demonstrations Side by Side

Unlike workflow test kits where Inferno's client and server suites call each
other directly, the US Quality Core suites primarily share the local Inferno
Reference Server as a demonstration data source.

A typical local demonstration is:

1. Run the server suite with the **Inferno Reference Server** preset to evaluate
   the reference server as a US Quality Core data source.
2. Run the client suite and point a client or the generated Postman collection
   at Inferno's simulated client-suite FHIR base URL.
3. Compare the client requests with the server-suite requirements for the same
   profiles and searches.

This is useful for debugging generated search expectations, target resource
IDs, and reference-server data coverage.
