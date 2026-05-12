require_relative '../../../read_test'

module USQualityCoreTestKit
  module USQualityCoreV010
    class SpecimenReadTest < Inferno::Test
      include USQualityCoreTestKit::ReadTest

      title 'Server returns correct Specimen resource from Specimen read interaction'

      description 'A server SHALL support the Specimen read interaction.'

      id :us_quality_core_v010_specimen_read_test

      def resource_type
        'Specimen'
      end

      def scratch_resources
        scratch[:specimen_resources] ||= {}
      end

      run do
        perform_read_test(scratch.dig(:references, 'Specimen'), delayed_reference: true)
      end
    end
  end
end
