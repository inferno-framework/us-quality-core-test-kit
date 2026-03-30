require_relative 'adverse_event/adverse_event_subject_search_test'
require_relative 'adverse_event/adverse_event_subject_event_search_test'
require_relative 'adverse_event/adverse_event_subject_recordeddate_search_test'
require_relative 'adverse_event/adverse_event_read_test'
require_relative 'adverse_event/adverse_event_validation_test'
require_relative 'adverse_event/adverse_event_must_support_test'
require_relative 'adverse_event/adverse_event_reference_resolution_test'


module USQualityCoreTestKit
  module USQualityCoreV010
    class AdverseEventGroup < Inferno::TestGroup
      title 'AdverseEvent Tests'

      short_description 'Verify support for the capabilities required by the US Quality Core AdverseEvent.'

      description %(
  # Background

These tests verify that the system under test is able to provide correct
responses for AdverseEvent queries. These queries must contain resources
conforming to the US Quality Core AdverseEvent as specified in the US Quality Core Implementation Guide.

# Testing Methodology
## Searching
This test sequence will first perform each required search associated
with this resource. This sequence will perform searches with the
following parameters:

* subject
* subject + event
* subject + recordedDate

### Search Parameters
The first search uses the selected patient(s) from the prior launch
sequence. Any subsequent searches will look for its parameter values
from the results of the first search. For example, the `identifier`
search in the patient sequence is performed by looking for an existing
`Patient.identifier` from any of the resources returned in the `_id`
search. If a value cannot be found this way, the search is skipped.

### Search Validation
Inferno will retrieve up to the first 20 bundle pages of the reply for
AdverseEvent resources and save them for subsequent tests. Each of
these resources is then checked to see if it matches the searched
parameters in accordance with [FHIR search
guidelines](https://www.hl7.org/fhir/search.html). The test will fail,
for example, if a Patient search for `gender=male` returns a `female`
patient.


## Must Support
Each profile contains elements marked as "must support" or with
"USCDI+ Quality" tags. This test sequence expects to see each of these
elements at least once. If at least one cannot be found, the test will
fail. The test will look through the AdverseEvent resources found
in the first test for these elements.

## Profile Validation
Each resource returned from the first search is expected to conform to
the [US Quality Core AdverseEvent Profile](http://fhir.org/guides/astp/us-quality-core/StructureDefinition/us-quality-core-adverseevent). Each element is checked against
teminology binding and cardinality requirements.

Elements with a required binding are validated against their bound
ValueSet. If the code/system in the element is not part of the ValueSet,
then the test will fail.

## Reference Validation
At least one instance of each external reference in elements marked as
"must support" within the resources provided by the system must resolve.
The test will attempt to read each reference found and will fail if no
read succeeds.

      )

      id :us_quality_core_v010_adverse_event

      run_as_group

      

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'adverse_event', 'metadata.yml'), aliases: true))
      end

  
      test from: :us_quality_core_v010_adverse_event_subject_search_test
      test from: :us_quality_core_v010_adverse_event_subject_event_search_test
      test from: :us_quality_core_v010_adverse_event_subject_recordedDate_search_test
      test from: :us_quality_core_v010_adverse_event_read_test
      test from: :us_quality_core_v010_adverse_event_validation_test
      test from: :us_quality_core_v010_adverse_event_must_support_test
      test from: :us_quality_core_v010_adverse_event_reference_resolution_test
    end
  end
end
