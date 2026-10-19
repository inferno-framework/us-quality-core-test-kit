# frozen_string_literal: true

require 'securerandom'

module USQualityCoreTestKit
  module Client
    module USQualityCoreClientV100_BALLOT
      class WaitGroup < Inferno::TestGroup
        include URLs

        id :us_quality_core_client_access_group_v100_ballot
        title 'Client Access'
        description %(
          During these tests, Inferno will simulate a US Quality Core FHIR Server for the client to
          use to access data. Inferno will wait while the client submits requests and will
          both respond with data and collect the requests for later analysis.
        )

        run_as_group

        def suite_id
          return config.options[:endpoint_suite_id] if config.options[:endpoint_suite_id].present?

          'us_quality_core_client_v100_ballot'
        end

        group do
          id :us_quality_core_client_wait_group_v100_ballot
          title 'Perform Data Access'

          test do
            id :us_quality_core_client_wait_test_v100_ballot
            title 'Wait for Requests'
            description %(
              This test will wait for the client under test to submit requests for resources for
              each of the US Quality Core profiles, and for requests including all of the required search
              parameters for each resource type.
            )

            output :access_token

            run do
              token = SecureRandom.uuid
              output access_token: token

              wait(
                identifier: token,
                message: %(
  Inferno will now wait for the client under test to make the required requests against the following base URL:

  #{fhir_url}

  Inferno generated this access token for the current run:

  `#{token}`

  Configure the client under test to send the following HTTP header with every request.
  Clients must send this exact value as the bearer token for this run.
  If the client system already adds the `Bearer` scheme, enter only the access
  token value shown above in the client configuration.

  `Authorization: Bearer #{token}`

  All requests will be recorded. When finished, the requests will be inspected to ensure that the client under test is making the required requests.
  Requests should target the following patient record:
  - **Resource ID**: `usqualitycore-patient`

  [Click here](#{resume_pass_url}?token=#{token}) when finished.

  The following requirements will be checked:

  * **Patient**
  * read: any Patient resource (any ID)
  * searches:
    * _id
* **AdverseEvent**
  * read: any AdverseEvent resource (any ID)
  * searches:
    * subject
    * subject + event
    * subject + recorded-date
* **AllergyIntolerance**
  * read: any AllergyIntolerance resource (any ID)
  * searches:
    * patient
* **CarePlan**
  * read: any CarePlan resource (any ID)
  * searches:
    * patient + category
* **CareTeam**
  * read: any CareTeam resource (any ID)
  * searches:
    * patient + status
* **Communication**
  * read: any Communication resource (any ID)
  * searches:
    * subject + status
    * subject
    * subject + topic
* **Communicationdone**
  * read: any Communication resource (any ID)
  * searches:
    * subject + status
    * subject
    * subject + topic
* **Communicationnotdone**
  * read: any Communication resource (any ID)
  * searches:
    * subject + status
    * subject
    * subject + topic
* **ConditionEncounterDiagnosis**
  * read: any Condition resource (any ID)
  * searches:
    * patient + category
    * patient
    * patient + code
* **ConditionProblemsHealthConcerns**
  * read: any Condition resource (any ID)
  * searches:
    * patient + category
    * patient
    * patient + code
* **Coverage**
  * read: any Coverage resource (any ID)
  * searches:
    * patient
* **Device**
  * read: any Device resource (any ID)
  * searches:
    * patient
    * patient + type
* **Devicerequest**
  * read: any DeviceRequest resource (any ID)
  * searches:
    * patient
    * patient + code
    * patient + do-not-perform
* **Devicerequested**
  * read: any DeviceRequest resource (any ID)
  * searches:
    * patient + do-not-perform
    * patient
    * patient + code
* **Deviceprohibited**
  * read: any DeviceRequest resource (any ID)
  * searches:
    * patient + do-not-perform
    * patient
    * patient + code
* **DiagnosticReportNote**
  * read: any DiagnosticReport resource (any ID)
  * searches:
    * patient + category
    * patient
    * patient + category + date
    * patient + code
* **DiagnosticReportLab**
  * read: any DiagnosticReport resource (any ID)
  * searches:
    * patient + category
    * patient
    * patient + category + date
    * patient + code
* **UsCoreDocumentreference**
  * read: any DocumentReference resource (any ID)
  * searches:
    * patient + category
    * patient
    * _id
    * patient + type
    * patient + category + date
* **UsCoreAdiDocumentreference**
  * read: any DocumentReference resource (any ID)
  * searches:
    * patient + category
    * patient
    * _id
    * patient + type
    * patient + category + date
* **FamilyMemberHistory**
  * read: any FamilyMemberHistory resource (any ID)
  * searches:
    * patient
* **Goal**
  * read: any Goal resource (any ID)
  * searches:
    * patient
* **ImagingStudy**
  * read: any ImagingStudy resource (any ID)
  * searches:
    * subject
* **Immunization**
  * read: any Immunization resource (any ID)
  * searches:
    * patient + status
    * patient
* **Immunizationnotdone**
  * read: any Immunization resource (any ID)
  * searches:
    * patient + status
    * patient
* **Immunizationdone**
  * read: any Immunization resource (any ID)
  * searches:
    * patient + status
    * patient
* **Medicationadministration**
  * read: any MedicationAdministration resource (any ID)
  * searches:
    * patient + status
    * patient
    * patient + code
    * patient + effective-time
* **Medicationadministrationnotdone**
  * read: any MedicationAdministration resource (any ID)
  * searches:
    * patient + status
    * patient
    * patient + code
    * patient + effective-time
* **Medicationadministrationdone**
  * read: any MedicationAdministration resource (any ID)
  * searches:
    * patient + status
    * patient
    * patient + code
    * patient + effective-time
* **Medicationdispense**
  * read: any MedicationDispense resource (any ID)
  * searches:
    * patient + status
    * patient
* **Medicationdispensedeclined**
  * read: any MedicationDispense resource (any ID)
  * searches:
    * patient + status
    * patient
* **Medicationdispensedone**
  * read: any MedicationDispense resource (any ID)
  * searches:
    * patient + status
    * patient
* **Medicationrequest**
  * read: any MedicationRequest resource (any ID)
  * searches:
    * patient + intent
    * patient + intent + do-not-perform
* **Medicationprohibited**
  * read: any MedicationRequest resource (any ID)
  * searches:
    * patient + intent + do-not-perform
    * patient + intent
* **Medicationrequested**
  * read: any MedicationRequest resource (any ID)
  * searches:
    * patient + intent + do-not-perform
    * patient + intent
* **NutritionOrder**
  * read: any NutritionOrder resource (any ID)
  * searches:
    * patient
* **ObservationClinicalResult**
  * read: any Observation resource (any ID)
  * searches:
    * patient + category + status
    * patient + category
    * patient + category + date
    * patient + code
* **UsCoreObservationAdiDocumentation**
  * read: any Observation resource (any ID)
  * searches:
    * patient + code
    * patient + category + status
    * patient + category
    * patient + category + date
* **UsCoreTreatmentInterventionPreference**
  * read: any Observation resource (any ID)
  * searches:
    * patient + code
    * patient + category + status
    * patient + category
    * patient + category + date
* **SimpleObservation**
  * read: any Observation resource (any ID)
  * searches:
    * patient + category + status
    * patient + category
    * patient + category + date
    * patient + code
* **ObservationScreeningAssessment**
  * read: any Observation resource (any ID)
  * searches:
    * patient + category + status
    * patient + category
    * patient + category + date
    * patient + code
* **UsCoreObservationPregnancystatus**
  * read: any Observation resource (any ID)
  * searches:
    * patient + code
    * patient + category + status
    * patient + category
    * patient + category + date
* **UsCoreObservationPregnancyintent**
  * read: any Observation resource (any ID)
  * searches:
    * patient + code
    * patient + category + status
    * patient + category
    * patient + category + date
* **UsCoreSmokingstatus**
  * read: any Observation resource (any ID)
  * searches:
    * patient + code
    * patient + category + status
    * patient + category
    * patient + category + date
* **ObservationLab**
  * read: any Observation resource (any ID)
  * searches:
    * patient + category + status
    * patient + category
    * patient + category + date
    * patient + code
* **UsCoreObservationOccupation**
  * read: any Observation resource (any ID)
  * searches:
    * patient + code
    * patient + category + status
    * patient + category
    * patient + category + date
* **UsCoreBloodPressure**
  * read: any Observation resource (any ID)
  * searches:
    * patient + code
    * patient + category + status
    * patient + category
    * patient + category + date
* **UsCoreBmi**
  * read: any Observation resource (any ID)
  * searches:
    * patient + code
    * patient + category + status
    * patient + category
    * patient + category + date
* **PediatricBmiForAge**
  * read: any Observation resource (any ID)
  * searches:
    * patient + code
    * patient + category + status
    * patient + category
    * patient + category + date
* **UsCoreBodyHeight**
  * read: any Observation resource (any ID)
  * searches:
    * patient + code
    * patient + category + status
    * patient + category
    * patient + category + date
* **UsCoreBodyTemperature**
  * read: any Observation resource (any ID)
  * searches:
    * patient + code
    * patient + category + status
    * patient + category
    * patient + category + date
* **UsCoreBodyWeight**
  * read: any Observation resource (any ID)
  * searches:
    * patient + code
    * patient + category + status
    * patient + category
    * patient + category + date
* **HeadOccipitalFrontalCircumferencePercentile**
  * read: any Observation resource (any ID)
  * searches:
    * patient + code
    * patient + category + status
    * patient + category
    * patient + category + date
* **UsCoreHeartRate**
  * read: any Observation resource (any ID)
  * searches:
    * patient + code
    * patient + category + status
    * patient + category
    * patient + category + date
* **UsCorePulseOximetry**
  * read: any Observation resource (any ID)
  * searches:
    * patient + code
    * patient + category + status
    * patient + category
    * patient + category + date
* **UsCoreRespiratoryRate**
  * read: any Observation resource (any ID)
  * searches:
    * patient + code
    * patient + category + status
    * patient + category
    * patient + category + date
* **PediatricWeightForHeight**
  * read: any Observation resource (any ID)
  * searches:
    * patient + code
    * patient + category + status
    * patient + category
    * patient + category + date
* **Procedure**
  * read: any Procedure resource (any ID)
  * searches:
    * patient + status
    * patient
    * patient + date
* **Procedurenotdone**
  * read: any Procedure resource (any ID)
  * searches:
    * patient + status
    * patient
    * patient + date
* **Proceduredone**
  * read: any Procedure resource (any ID)
  * searches:
    * patient + status
    * patient
    * patient + date
* **QuestionnaireResponse**
  * read: any QuestionnaireResponse resource (any ID)
  * searches:
    * patient
    * patient + questionnaire
* **RelatedPerson**
  * read: any RelatedPerson resource (any ID)
  * searches:
    * patient
    * _id
* **Servicerequest**
  * read: any ServiceRequest resource (any ID)
  * searches:
    * patient
    * _id
    * patient + category
    * patient + category + authored
    * patient + code
    * patient + do-not-perform
* **Serviceprohibited**
  * read: any ServiceRequest resource (any ID)
  * searches:
    * patient + do-not-perform
    * _id
    * patient
    * patient + category
    * patient + category + authored
    * patient + code
* **Servicerequested**
  * read: any ServiceRequest resource (any ID)
  * searches:
    * patient + do-not-perform
    * _id
    * patient
    * patient + category
    * patient + category + authored
    * patient + code
* **Task**
  * read: any Task resource (any ID)
  * searches:
    * patient + status
    * patient
    * patient + code
* **Taskrejected**
  * read: any Task resource (any ID)
  * searches:
    * patient + status
    * patient
    * patient + code
* **Taskdone**
  * read: any Task resource (any ID)
  * searches:
    * patient + status
    * patient
    * patient + code
* **Encounter**
  * read: any Encounter resource (any ID)
  * searches:
    * patient
    * _id
    * patient + type
    * patient + date
* **Location**
  * read: any Location resource (any ID)
  * searches:

* **Organization**
  * read: any Organization resource (any ID)
  * searches:

* **Practitioner**
  * read: any Practitioner resource (any ID)
  * searches:

* **PractitionerRole**
  * read: any PractitionerRole resource (any ID)
  * searches:

* **Provenance**
  * read: any Provenance resource (any ID)
  * searches:

* **Specimen**
  * read: any Specimen resource (any ID)
  * searches:
    * _id
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
