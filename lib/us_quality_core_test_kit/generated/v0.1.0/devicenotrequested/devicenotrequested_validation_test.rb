require_relative '../../../validation_test'

module USQualityCoreTestKit
  module USQualityCoreV010
    class DevicenotrequestedValidationTest < Inferno::Test
      include USQualityCoreTestKit::ValidationTest

      id :us_quality_core_v010_devicenotrequested_validation_test

      title 'DeviceRequest resources returned during previous tests conform to the US Quality Core Device Not Requested'

      description %(
This test verifies resources returned from the first search conform to
the [US Quality Core Device Not Requested](http://fhir.org/guides/onc/us-quality-core/StructureDefinition/us-quality-core-devicenotrequested).
Systems must demonstrate at least one valid example in order to pass this test.

It verifies the presence of mandatory elements and that elements with
required bindings contain appropriate values. CodeableConcept element
bindings will fail if none of their codings have a code/system belonging
to the bound ValueSet. Quantity, Coding, and code element bindings will
fail if their code/system are not found in the valueset.

      )

      output :dar_code_found, :dar_extension_found

      def resource_type
        'DeviceRequest'
      end

      def scratch_resources
        scratch[:devicenotrequested_resources] ||= {}
      end

      run do
        perform_validation_test(scratch_resources[:all] || [],
                                'http://fhir.org/guides/onc/us-quality-core/StructureDefinition/us-quality-core-devicenotrequested',
                                '0.1.0',
                                skip_if_empty: true)
      end
    end
  end
end
