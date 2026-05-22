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
    * us-quality-core-test-kit-adverse-event
  * searches:
    * subject
    * subject + event
    * subject + recorded-date
* **AllergyIntolerance**
  * read id:
    * us-quality-core-test-kit-allergy-intolerance
  * searches:
    * patient
* **CarePlan**
  * read id:
    * us-quality-core-test-kit-care-plan
  * searches:
    * patient + category
* **CareTeam**
  * read id:
    * us-quality-core-test-kit-care-team
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
    * patient + code
* **ConditionProblemsHealthConcerns**
  * read id:
    * us-quality-core-test-kit-condition-problems-health-concerns
  * searches:
    * patient + category
    * patient
    * patient + code
* **Coverage**
  * read id:
    * us-quality-core-test-kit-coverage
  * searches:
    * patient
* **Devicerequest**
  * read id:
    * us-quality-core-test-kit-devicerequest
  * searches:
    * patient + do-not-perform
    * patient
    * patient + code
* **Devicenotrequested**
  * read id:
    * us-quality-core-test-kit-devicenotrequested
  * searches:
    * patient + do-not-perform
    * patient
    * patient + code
* **DiagnosticReportNote**
  * read id:
    * us-quality-core-test-kit-diagnostic-report-note
  * searches:
    * patient + category
    * patient
    * patient + category + date
    * patient + code
* **DiagnosticReportLab**
  * read id:
    * us-quality-core-test-kit-diagnostic-report-lab
  * searches:
    * patient + category
    * patient
    * patient + category + date
    * patient + code
* **DocumentReference**
  * read id:
    * us-quality-core-test-kit-document-reference
  * searches:
    * patient
    * _id
    * patient + type
    * patient + category
    * patient + category + date
* **FamilyMemberHistory**
  * read id:
    * us-quality-core-test-kit-family-member-history
  * searches:
    * patient
* **Goal**
  * read id:
    * us-quality-core-test-kit-goal
  * searches:
    * patient
* **ImagingStudy**
  * read id:
    * us-quality-core-test-kit-imaging-study
  * searches:
    * patient
    * patient + procedure-code
* **Immunization**
  * read id:
    * us-quality-core-test-kit-immunization
  * searches:
    * patient + status
    * patient
* **Immunizationnotdone**
  * read id:
    * us-quality-core-test-kit-immunizationnotdone
  * searches:
    * patient + status
    * patient
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
    * patient + intent + do-not-perform
    * patient + intent
* **Medicationnotrequested**
  * read id:
    * us-quality-core-test-kit-medicationnotrequested
  * searches:
    * patient + intent + do-not-perform
    * patient + intent
* **ObservationClinicalResult**
  * read id:
    * us-quality-core-test-kit-observation-clinical-result
    * us-quality-core-test-kit-observation-lab
  * searches:
    * patient + category + status
    * patient + category
    * patient + category + date
    * patient + code
* **SimpleObservation**
  * read id:
    * us-quality-core-test-kit-simple-observation
  * searches:
    * patient + category + status
    * patient + category
    * patient + category + date
    * patient + code
* **ObservationScreeningAssessment**
  * read id:
    * us-quality-core-test-kit-observation-screening-assessment
  * searches:
    * patient + category + status
    * patient + category
    * patient + category + date
    * patient + code
* **Observationcancelled**
  * read id:
    * us-quality-core-test-kit-observationcancelled
  * searches:
    * patient + category + status
    * patient + category
    * patient + category + date
    * patient + code
* **UsCoreObservationPregnancyintent**
  * read id:
    * us-quality-core-test-kit-us-core-observation-pregnancyintent
  * searches:
    * patient + code
    * patient + category + status
    * patient + category
    * patient + category + date
* **UsCoreObservationPregnancystatus**
  * read id:
    * us-quality-core-test-kit-us-core-observation-pregnancystatus
  * searches:
    * patient + code
    * patient + category + status
    * patient + category
    * patient + category + date
* **UsCoreSmokingstatus**
  * read id:
    * us-quality-core-test-kit-us-core-smokingstatus
  * searches:
    * patient + code
    * patient + category + status
    * patient + category
    * patient + category + date
* **ObservationLab**
  * read id:
    * us-quality-core-test-kit-observation-lab
  * searches:
    * patient + category + status
    * patient + category
    * patient + category + date
    * patient + code
* **UsCoreObservationOccupation**
  * read id:
    * us-quality-core-test-kit-us-core-observation-occupation
  * searches:
    * patient + code
    * patient + category + status
    * patient + category
    * patient + category + date
* **UsCoreBloodPressure**
  * read id:
    * us-quality-core-test-kit-us-core-blood-pressure
  * searches:
    * patient + code
    * patient + category + status
    * patient + category
    * patient + category + date
* **UsCoreBmi**
  * read id:
    * us-quality-core-test-kit-us-core-bmi
  * searches:
    * patient + code
    * patient + category + status
    * patient + category
    * patient + category + date
* **PediatricBmiForAge**
  * read id:
    * us-quality-core-test-kit-pediatric-bmi-for-age
  * searches:
    * patient + category + status
    * patient + category
    * patient + category + date
    * patient + code
* **UsCoreBodyHeight**
  * read id:
    * us-quality-core-test-kit-us-core-body-height
  * searches:
    * patient + code
    * patient + category + status
    * patient + category
    * patient + category + date
* **UsCoreBodyTemperature**
  * read id:
    * us-quality-core-test-kit-us-core-body-temperature
  * searches:
    * patient + code
    * patient + category + status
    * patient + category
    * patient + category + date
* **UsCoreBodyWeight**
  * read id:
    * us-quality-core-test-kit-us-core-body-weight
  * searches:
    * patient + code
    * patient + category + status
    * patient + category
    * patient + category + date
* **HeadOccipitalFrontalCircumferencePercentile**
  * read id:
    * us-quality-core-test-kit-head-circumference-percentile
  * searches:
    * patient + category + status
    * patient + category
    * patient + category + date
    * patient + code
* **UsCoreHeartRate**
  * read id:
    * us-quality-core-test-kit-us-core-heart-rate
  * searches:
    * patient + code
    * patient + category + status
    * patient + category
    * patient + category + date
* **UsCorePulseOximetry**
  * read id:
    * us-quality-core-test-kit-us-core-pulse-oximetry
  * searches:
    * patient + code
    * patient + category + status
    * patient + category
    * patient + category + date
* **UsCoreRespiratoryRate**
  * read id:
    * us-quality-core-test-kit-us-core-respiratory-rate
  * searches:
    * patient + code
    * patient + category + status
    * patient + category
    * patient + category + date
* **PediatricWeightForHeight**
  * read id:
    * us-quality-core-test-kit-pediatric-weight-for-height
  * searches:
    * patient + category + status
    * patient + category
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
    * us-quality-core-test-kit-related-person
  * searches:
    * patient
    * _id
* **Servicerequest**
  * read id:
    * us-quality-core-test-kit-servicerequest
  * searches:
    * patient + do-not-perform
    * _id
    * patient
    * patient + category
    * patient + category + authored
    * patient + code
* **Servicenotrequested**
  * read id:
    * us-quality-core-test-kit-servicenotrequested
  * searches:
    * patient + do-not-perform
    * _id
    * patient
    * patient + category
    * patient + category + authored
    * patient + code
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

* **Organization**
  * read id:
    * us-quality-core-test-kit-organization
  * searches:

* **Practitioner**
  * read id:
    * us-quality-core-test-kit-practitioner
  * searches:

* **PractitionerRole**
  * read id:
    * us-quality-core-test-kit-practitioner-role
  * searches:

* **Provenance**
  * read id:
    * us-quality-core-test-kit-provenance
  * searches:

* **Specimen**
  * read id:
    * us-quality-core-test-kit-specimen
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
