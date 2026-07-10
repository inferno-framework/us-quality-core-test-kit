require_relative 'location/location_read_test'
require_relative 'location/location_validation_test'
require_relative 'location/location_must_support_test'
require_relative 'location/location_reference_resolution_test'


module USQualityCoreTestKit
  module USQualityCoreV100
    class LocationGroup < Inferno::TestGroup
      title 'Location Tests'

      short_description 'Verify support for the capabilities required by the US Quality Core Location.'

      description %(
  # Background

These tests verify that the system under test is able to provide correct
responses for Location queries. These queries must contain resources
conforming to the US Quality Core Location as specified in the US Quality Core Implementation Guide.

# Testing Methodology


## Must Support
Each profile contains elements marked as "must support" or with
"USCDI+ Quality" tags. This test sequence expects to see each of these
elements at least once. If at least one cannot be found, the test will
fail. The test will look through the Location resources found
in the first test for these elements.

## Profile Validation
Each resource returned from the first search is expected to conform to
the [US Quality Core Location Profile](http://hl7.org/fhir/us/quality-core/StructureDefinition/us-quality-core-location). Each element is checked against
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

      id :us_quality_core_v100_location

      run_as_group

      

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'location', 'metadata.yml'), aliases: true))
      end

  
      test from: :us_quality_core_v100_location_read_test
      test from: :us_quality_core_v100_location_validation_test
      test from: :us_quality_core_v100_location_must_support_test
      test from: :us_quality_core_v100_location_reference_resolution_test
    end
  end
end
