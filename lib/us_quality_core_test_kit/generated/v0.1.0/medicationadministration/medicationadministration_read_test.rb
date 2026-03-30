require_relative '../../../read_test'

module USQualityCoreTestKit
  module USQualityCoreV010
    class MedicationadministrationReadTest < Inferno::Test
      include USQualityCoreTestKit::ReadTest

      title 'Server returns correct MedicationAdministration resource from MedicationAdministration read interaction'

      description 'A server SHALL support the MedicationAdministration read interaction.'

      id :us_quality_core_v010_medicationadministration_read_test

      def resource_type
        'MedicationAdministration'
      end

      def scratch_resources
        scratch[:medicationadministration_resources] ||= {}
      end

      run do
        perform_read_test(all_scratch_resources)
      end
    end
  end
end
