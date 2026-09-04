require_relative '../../../read_test'

module USQualityCoreTestKit
  module USQualityCoreV100_BALLOT
    class MedicationadministrationdoneReadTest < Inferno::Test
      include USQualityCoreTestKit::ReadTest

      title 'Server returns correct MedicationAdministration resource from MedicationAdministration read interaction'

      description 'A server SHALL support the MedicationAdministration read interaction.'

      id :us_quality_core_v100_ballot_medicationadministrationdone_read_test

      def resource_type
        'MedicationAdministration'
      end

      def scratch_resources
        scratch[:medicationadministrationdone_resources] ||= {}
      end

      run do
        perform_read_test(all_scratch_resources)
      end
    end
  end
end
