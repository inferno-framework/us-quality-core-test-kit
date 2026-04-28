# frozen_string_literal: true

module USQualityCoreTestKit
  module Client
    module USQualityCoreClientV010
      class WaitGroup < Inferno::TestGroup
        include URLs

        id :us_quality_core_client_access_group_v010
        title 'Client Access'
        description %(
          During these tests, Inferno will simulate a US Quality Core FHIR Server for the client to
          use to access data. Inferno will wait while the client submits requests and will
          both respond with data and collect the requests for later analysis.
        )

        run_as_group

        def suite_id
          return config.options[:endpoint_suite_id] if config.options[:endpoint_suite_id].present?

          'us_quality_core_client_v010'
        end

        group do
          id :us_quality_core_client_wait_group_v010
          title 'Perform Data Access'

          test do
            id :us_quality_core_client_wait_test_v010
            title 'Wait for Requests'
            description %(
              This test will wait for the client under test to submit requests for resources for
              each of the US Quality Core profiles, and for requests including all of the required search
              parameters for each resource type.
            )

            input :client_id,
                  title: 'Client Id',
                  type: 'text'

            run do
              wait(
                identifier: client_id,
                message: %(
  Inferno will now wait for the client under test to make the required requests against the following base URL:

  #{fhir_url}

  All requests will be recorded. When finished, the requests will be inspected to ensure that the client under test is making the required requests.
  Requests should target the following patient record:
  - **Resource ID**: `us-quality-core-test-kit-patient`

  [Click here](#{resume_pass_url}?token=#{client_id}) when finished.

  The following requirements will be checked:

  * **Patient**
  * read id:
    * us-quality-core-test-kit-patient
  * searches:
    * _id
* **AdverseEvent**
  * read id:
    * us-quality-core-test-kit-adverseevent
  * searches:
    * subject
    * subject + event
    * subject + recorded-date
* **AllergyIntolerance**
  * read id:
    * us-quality-core-test-kit-allergyintolerance
  * searches:
    * patient
* **CarePlan**
  * read id:
    * us-quality-core-test-kit-careplan
  * searches:
    * patient + category
* **CareTeam**
  * read id:
    * us-quality-core-test-kit-careteam
  * searches:
    * patient + status
* **Claim**
  * read id:
    * us-quality-core-test-kit-claim
  * searches:
    * patient
* **ConditionEncounterDiagnosis**
  * read id:
    * us-quality-core-test-kit-condition-encounter-diagnosis
  * searches:
    * patient + category
    * patient
    * patient + abatement-date
    * patient + code
    * patient + onset-date
* **ConditionProblemsHealthConcerns**
  * read id:
    * us-quality-core-test-kit-condition-problems-health-concerns
  * searches:
    * patient + category
    * patient
    * patient + abatement-date
    * patient + code
    * patient + onset-date
* **Coverage**
  * read id:
    * us-quality-core-test-kit-coverage
  * searches:
    * patient
* **Devicerequest**
  * read id:
    * us-quality-core-test-kit-devicerequest
  * searches:
    * patient
    * patient + code
    * patient + do-not-perform
* **Devicenotrequested**
  * read id:
    * us-quality-core-test-kit-devicenotrequested
  * searches:
    * patient
    * patient + code
    * patient + do-not-perform
* **DiagnosticReportNote**
  * read id:
    * us-quality-core-test-kit-diagnosticreport-note
  * searches:
    * patient + category
    * patient
    * patient + category + date
    * patient + code
* **DiagnosticReportLab**
  * read id:
    * us-quality-core-test-kit-diagnosticreport-lab
  * searches:
    * patient + category
    * patient
    * patient + category + date
    * patient + code
* **FamilyMemberHistory**
  * read id:
    * us-quality-core-test-kit-familymemberhistory
  * searches:
    * patient
* **Goal**
  * read id:
    * us-quality-core-test-kit-goal
  * searches:
    * patient
* **Immunization**
  * read id:
    * us-quality-core-test-kit-immunization
  * searches:
    * patient + status
    * patient
    * patient + date
* **Immunizationnotdone**
  * read id:
    * us-quality-core-test-kit-immunizationnotdone
  * searches:
    * patient + status
    * patient
    * patient + date
* **Medicationadministration**
  * read id:
    * us-quality-core-test-kit-medicationadministration
  * searches:
    * patient + status
    * patient
    * patient + code
    * patient + effective-time
* **Medicationadministrationnotdone**
  * read id:
    * us-quality-core-test-kit-medicationadministrationnotdone
  * searches:
    * patient + status
    * patient
    * patient + code
    * patient + effective-time
* **Medicationdispense**
  * read id:
    * us-quality-core-test-kit-medicationdispense
  * searches:
    * patient + status
    * patient
* **Medicationdispensedeclined**
  * read id:
    * us-quality-core-test-kit-medicationdispensedeclined
  * searches:
    * patient + status
    * patient
* **Medicationrequest**
  * read id:
    * us-quality-core-test-kit-medicationrequest
  * searches:
    * patient + intent
    * patient + intent + do-not-perform
* **Medicationnotrequested**
  * read id:
    * us-quality-core-test-kit-medicationnotrequested
  * searches:
    * patient + intent
    * patient + intent + do-not-perform
* **ObservationClinicalResult**
  * read id:
    * us-quality-core-test-kit-observation-clinical-result
  * searches:
    * patient + category
    * patient + category + status
    * patient + category + date
    * patient + code
* **SimpleObservation**
  * read id:
    * us-quality-core-test-kit-simple-observation
  * searches:
    * patient + category
    * patient + category + status
    * patient + category + date
    * patient + code
* **ObservationScreeningAssessment**
  * read id:
    * us-quality-core-test-kit-observation-screening-assessment
  * searches:
    * patient + category
    * patient + category + status
    * patient + category + date
    * patient + code
* **Observationcancelled**
  * read id:
    * us-quality-core-test-kit-observationcancelled
  * searches:
    * patient + code
    * patient + category + status
    * patient + category
    * patient + category + date
* **ObservationLab**
  * read id:
    * us-quality-core-test-kit-observation-lab
  * searches:
    * patient + category
    * patient + category + status
    * patient + category + date
    * patient + code
* **Procedure**
  * read id:
    * us-quality-core-test-kit-procedure
  * searches:
    * patient + status
    * patient
    * patient + date
* **Procedurenotdone**
  * read id:
    * us-quality-core-test-kit-procedurenotdone
  * searches:
    * patient + status
    * patient
    * patient + date
* **RelatedPerson**
  * read id:
    * us-quality-core-test-kit-relatedperson
  * searches:
    * patient
    * _id
* **Servicerequest**
  * read id:
    * us-quality-core-test-kit-servicerequest
  * searches:
    * patient + category
    * _id
    * patient
    * patient + category + authored
    * patient + code
    * patient + do-not-perform
* **Servicenotrequested**
  * read id:
    * us-quality-core-test-kit-servicenotrequested
  * searches:
    * patient + category
    * _id
    * patient
    * patient + category + authored
    * patient + code
    * patient + do-not-perform
* **Task**
  * read id:
    * us-quality-core-test-kit-task
  * searches:
    * patient + status
    * patient
    * patient + code
* **Taskrejected**
  * read id:
    * us-quality-core-test-kit-taskrejected
  * searches:
    * patient + status
    * patient
    * patient + code
* **Encounter**
  * read id:
    * us-quality-core-test-kit-encounter
  * searches:
    * patient
    * _id
    * patient + type
    * patient + date
* **Location**
  * read id:
    * us-quality-core-test-kit-location
  * searches:
    * _id
* **Organization**
  * read id:
    * us-quality-core-test-kit-organization
  * searches:

* **Practitioner**
  * read id:
    * us-quality-core-test-kit-practitioner
  * searches:
    * _id
* **PractitionerRole**
  * read id:
    * us-quality-core-test-kit-practitionerrole
  * searches:
    * _id

  [Click here](#{resume_pass_url}?token=#{client_id}) when finished.
                ),
                timeout: 900
              )
            end
          end
        end
      end
    end
  end
end
