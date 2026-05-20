# frozen_string_literal: true

module USQualityCoreTestKit
  module Client
    module USQualityCoreClientV050
      class WaitGroup < Inferno::TestGroup
        include URLs

        id :us_quality_core_client_access_group_v050
        title 'Client Access'
        description %(
          During these tests, Inferno will simulate a US Quality Core FHIR Server for the client to
          use to access data. Inferno will wait while the client submits requests and will
          both respond with data and collect the requests for later analysis.
        )

        run_as_group

        def suite_id
          return config.options[:endpoint_suite_id] if config.options[:endpoint_suite_id].present?

          'us_quality_core_client_v050'
        end

        group do
          id :us_quality_core_client_wait_group_v050
          title 'Perform Data Access'

          test do
            id :us_quality_core_client_wait_test_v050
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
  - **Resource ID**: `usqualitycore-patient`

  [Click here](#{resume_pass_url}?token=#{client_id}) when finished.

  The following requirements will be checked:

  * **Patient**
  * read id:
    * usqualitycore-patient
  * searches:
    * _id
* **AdverseEvent**
  * read id:
    * usqualitycore-adverse-event
  * searches:
    * subject
    * subject + event
    * subject + recorded-date
* **AllergyIntolerance**
  * read id:
    * usqualitycore-allergy-intolerance
  * searches:
    * patient
* **CarePlan**
  * read id:
    * usqualitycore-care-plan
  * searches:
    * patient + category
* **CareTeam**
  * read id:
    * usqualitycore-care-team
  * searches:
    * patient + status
* **Claim**
  * read id:
    * usqualitycore-claim
  * searches:
    * patient
* **ConditionEncounterDiagnosis**
  * read id:
    * usqualitycore-condition-encounter-diagnosis
  * searches:
    * patient + category
    * patient
    * patient + code
* **ConditionProblemsHealthConcerns**
  * read id:
    * usqualitycore-condition-problems-health-concerns
  * searches:
    * patient + category
    * patient
    * patient + code
* **Coverage**
  * read id:
    * usqualitycore-coverage
  * searches:
    * patient
* **Devicerequest**
  * read id:
    * usqualitycore-devicerequest
  * searches:
    * patient + do-not-perform
    * patient
    * patient + code
* **Devicenotrequested**
  * read id:
    * usqualitycore-devicenotrequested
  * searches:
    * patient + do-not-perform
    * patient
    * patient + code
* **DiagnosticReportNote**
  * read id:
    * usqualitycore-diagnostic-report-note
  * searches:
    * patient + category
    * patient
    * patient + category + date
    * patient + code
* **DiagnosticReportLab**
  * read id:
    * usqualitycore-diagnostic-report-lab
  * searches:
    * patient + category
    * patient
    * patient + category + date
    * patient + code
* **FamilyMemberHistory**
  * read id:
    * usqualitycore-family-member-history
  * searches:
    * patient
* **Goal**
  * read id:
    * usqualitycore-goal
  * searches:
    * patient
* **ImagingStudy**
  * read id:
    * usqualitycore-imaging-study
  * searches:
    * patient
    * patient + procedure-code
* **Immunization**
  * read id:
    * usqualitycore-immunization
  * searches:
    * patient + status
    * patient
* **Immunizationnotdone**
  * read id:
    * usqualitycore-immunizationnotdone
  * searches:
    * patient + status
    * patient
* **Medicationadministration**
  * read id:
    * usqualitycore-medicationadministration
  * searches:
    * patient + status
    * patient
    * patient + code
    * patient + effective-time
* **Medicationadministrationnotdone**
  * read id:
    * usqualitycore-medicationadministrationnotdone
  * searches:
    * patient + status
    * patient
    * patient + code
    * patient + effective-time
* **Medicationdispense**
  * read id:
    * usqualitycore-medicationdispense
  * searches:
    * patient + status
    * patient
* **Medicationdispensedeclined**
  * read id:
    * usqualitycore-medicationdispensedeclined
  * searches:
    * patient + status
    * patient
* **Medicationrequest**
  * read id:
    * usqualitycore-medicationrequest
  * searches:
    * patient + intent + do-not-perform
    * patient + intent
* **Medicationnotrequested**
  * read id:
    * usqualitycore-medicationnotrequested
  * searches:
    * patient + intent + do-not-perform
    * patient + intent
* **ObservationClinicalResult**
  * read id:
    * usqualitycore-observation-clinical-result
    * usqualitycore-observation-lab
  * searches:
    * patient + category + status
    * patient + category
    * patient + category + date
    * patient + code
* **SimpleObservation**
  * read id:
    * usqualitycore-simple-observation
  * searches:
    * patient + category + status
    * patient + category
    * patient + category + date
    * patient + code
* **ObservationScreeningAssessment**
  * read id:
    * usqualitycore-observation-screening-assessment
  * searches:
    * patient + category + status
    * patient + category
    * patient + category + date
    * patient + code
* **Observationcancelled**
  * read id:
    * usqualitycore-observationcancelled
  * searches:
    * patient + category + status
    * patient + category
    * patient + category + date
    * patient + code
* **ObservationLab**
  * read id:
    * usqualitycore-observation-lab
  * searches:
    * patient + category + status
    * patient + category
    * patient + category + date
    * patient + code
* **Procedure**
  * read id:
    * usqualitycore-procedure
  * searches:
    * patient + status
    * patient
    * patient + date
* **Procedurenotdone**
  * read id:
    * usqualitycore-procedurenotdone
  * searches:
    * patient + status
    * patient
    * patient + date
* **RelatedPerson**
  * read id:
    * usqualitycore-related-person
  * searches:
    * patient
    * _id
* **Servicerequest**
  * read id:
    * usqualitycore-servicerequest
  * searches:
    * patient + do-not-perform
    * _id
    * patient
    * patient + category
    * patient + category + authored
    * patient + code
* **Servicenotrequested**
  * read id:
    * usqualitycore-servicenotrequested
  * searches:
    * patient + do-not-perform
    * _id
    * patient
    * patient + category
    * patient + category + authored
    * patient + code
* **Task**
  * read id:
    * usqualitycore-task
  * searches:
    * patient + status
    * patient
    * patient + code
* **Taskrejected**
  * read id:
    * usqualitycore-taskrejected
  * searches:
    * patient + status
    * patient
    * patient + code
* **Encounter**
  * read id:
    * usqualitycore-encounter
  * searches:
    * patient
    * _id
    * patient + type
    * patient + date
* **Location**
  * read id:
    * usqualitycore-location
  * searches:

* **Organization**
  * read id:
    * usqualitycore-organization
  * searches:

* **Practitioner**
  * read id:
    * usqualitycore-practitioner
  * searches:

* **PractitionerRole**
  * read id:
    * usqualitycore-practitioner-role
  * searches:


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
