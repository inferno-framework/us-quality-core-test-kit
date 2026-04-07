require_relative 'organization/organization_read_test'
require_relative 'organization/organization_validation_test'
require_relative 'organization/organization_must_support_test'


module USQualityCoreTestKit
  module USQualityCoreV010
    class OrganizationGroup < Inferno::TestGroup
      title 'Organization Tests'

      short_description 'Verify support for the capabilities required by the US Quality Core Organization.'

      description %(
  # Background

These tests verify that the system under test is able to provide correct
responses for Organization queries. These queries must contain resources
conforming to the US Quality Core Organization as specified in the US Quality Core Implementation Guide.

# Testing Methodology


## Must Support
Each profile contains elements marked as "must support" or with
"USCDI+ Quality" tags. This test sequence expects to see each of these
elements at least once. If at least one cannot be found, the test will
fail. The test will look through the Organization resources found
in the first test for these elements.

## Profile Validation
Each resource returned from the first search is expected to conform to
the [US Quality Core Organization Profile](http://fhir.org/guides/onc/us-quality-core/StructureDefinition/us-quality-core-organization). Each element is checked against
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

      id :us_quality_core_v010_organization

      run_as_group

      

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'organization', 'metadata.yml'), aliases: true))
      end

  
      test from: :us_quality_core_v010_organization_read_test
      test from: :us_quality_core_v010_organization_validation_test
      test from: :us_quality_core_v010_organization_must_support_test
    end
  end
end
