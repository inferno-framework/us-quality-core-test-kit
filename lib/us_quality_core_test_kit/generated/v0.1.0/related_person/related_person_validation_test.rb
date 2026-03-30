require_relative '../../../validation_test'

module USQualityCoreTestKit
  module USQualityCoreV010
    class RelatedPersonValidationTest < Inferno::Test
      include USQualityCoreTestKit::ValidationTest

      id :us_quality_core_v010_related_person_validation_test

      title 'RelatedPerson resources returned during previous tests conform to the US Quality Core RelatedPerson'

      description %(
This test verifies resources returned from the first search conform to
the [US Quality Core RelatedPerson](http://fhir.org/guides/astp/us-quality-core/StructureDefinition/us-quality-core-relatedperson).
Systems must demonstrate at least one valid example in order to pass this test.

It verifies the presence of mandatory elements and that elements with
required bindings contain appropriate values. CodeableConcept element
bindings will fail if none of their codings have a code/system belonging
to the bound ValueSet. Quantity, Coding, and code element bindings will
fail if their code/system are not found in the valueset.

      )

      output :dar_code_found, :dar_extension_found

      def resource_type
        'RelatedPerson'
      end

      def scratch_resources
        scratch[:related_person_resources] ||= {}
      end

      run do
        perform_validation_test(scratch_resources[:all] || [],
                                'http://fhir.org/guides/astp/us-quality-core/StructureDefinition/us-quality-core-relatedperson',
                                '0.1.0',
                                skip_if_empty: true)
      end
    end
  end
end
