require_relative '../../../read_test'

module USQualityCoreTestKit
  module USQualityCoreV010
    class MedicationdispensedeclinedReadTest < Inferno::Test
      include USQualityCoreTestKit::ReadTest

      title 'Server returns correct MedicationDispense resource from MedicationDispense read interaction'

      description 'A server SHALL support the MedicationDispense read interaction.'

      id :us_quality_core_v010_medicationdispensedeclined_read_test

      def resource_type
        'MedicationDispense'
      end

      def scratch_resources
        scratch[:medicationdispensedeclined_resources] ||= {}
      end

      run do
        perform_read_test(all_scratch_resources)
      end
    end
  end
end
