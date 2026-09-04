require_relative '../../../validation_test'

module USQualityCoreTestKit
  module USQualityCoreV100_BALLOT
    class PatientValidationTest < Inferno::Test
      include USQualityCoreTestKit::ValidationTest

      id :us_quality_core_v100_ballot_patient_validation_test

      title 'Patient resources returned during previous tests conform to the US Quality Core Patient Profile'

      description %(
This test verifies resources returned from the first search conform to
the [US Quality Core Patient Profile](http://hl7.org/fhir/us/quality-core/StructureDefinition/us-quality-core-patient).
Systems must demonstrate at least one valid example in order to pass this test.

It verifies the presence of mandatory elements and that elements with
required bindings contain appropriate values. CodeableConcept element
bindings will fail if none of their codings have a code/system belonging
to the bound ValueSet. Quantity, Coding, and code element bindings will
fail if their code/system are not found in the valueset.

Note: This test ignores validator messages for `Patient.extension`. This is a workaround for
a known validator package interaction where CQL can load US Core 7 definitions into the
validator session even though US Quality Core 0.5.0 is based on US Core 6.1.0.

      )

      output :dar_code_found, :dar_extension_found

      def resource_type
        'Patient'
      end

      def scratch_resources
        scratch[:patient_resources] ||= {}
      end

      run do
        perform_validation_test(scratch_resources[:all] || [],
                                'http://hl7.org/fhir/us/quality-core/StructureDefinition/us-quality-core-patient',
                                '1.0.0-ballot',
                                skip_if_empty: true)
      end
    end
  end
end
