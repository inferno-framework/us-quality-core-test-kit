require_relative '../../../validation_test'

module USQualityCoreTestKit
  module USQualityCoreV100_BALLOT
    class ImmunizationnotdoneValidationTest < Inferno::Test
      include USQualityCoreTestKit::ValidationTest

      id :us_quality_core_v100_ballot_immunizationnotdone_validation_test

      title 'Immunization resources returned during previous tests conform to the US Quality Core Immunization Not Done Profile'

      description %(
This test verifies resources returned from the first search conform to
the [US Quality Core Immunization Not Done Profile](http://hl7.org/fhir/us/quality-core/StructureDefinition/us-quality-core-immunizationnotdone).
Systems must demonstrate at least one valid example in order to pass this test.

It verifies the presence of mandatory elements and that elements with
required bindings contain appropriate values. CodeableConcept element
bindings will fail if none of their codings have a code/system belonging
to the bound ValueSet. Quantity, Coding, and code element bindings will
fail if their code/system are not found in the valueset.

      )

      output :dar_code_found, :dar_extension_found

      def resource_type
        'Immunization'
      end

      def scratch_resources
        scratch[:immunizationnotdone_resources] ||= {}
      end

      run do
        perform_validation_test(scratch_resources[:all] || [],
                                'http://hl7.org/fhir/us/quality-core/StructureDefinition/us-quality-core-immunizationnotdone',
                                '1.0.0-ballot',
                                skip_if_empty: true)
      end
    end
  end
end
