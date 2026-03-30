require_relative '../../../search_test'
require_relative '../../../generator/group_metadata'
require_relative '../../../search_test_properties'

module USQualityCoreTestKit
  module USQualityCoreV010
    class DevicenotrequestedPatientCodeSearchTest < Inferno::Test
      include USQualityCoreTestKit::SearchTest

      title 'Server returns valid results for DeviceRequest search by patient + code'

      description %(
A server SHALL support searching by
patient + code on the DeviceRequest resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.


      )

      id :us_quality_core_v010_devicenotrequested_patient_code_search_test

  

  
      input :patient_ids,
        title: 'Patient IDs',
        description: 'Comma separated list of patient IDs that in sum contain all MUST SUPPORT elements'
  

      def self.properties
        @properties ||= SearchTestProperties.new(
          resource_type: 'DeviceRequest',
        search_param_names: ['patient', 'code'],
        token_search_params: ['code']
        )
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:devicenotrequested_resources] ||= {}
      end

      run do
        run_search_test

        scratch_resources[:all]&.select! do |r|
          r&.modifierExtension&.any? do |e|
            e&.url&.include?('doNotPerform') && e&.valueBoolean
          end
        end
        skip_if scratch_resources[:all].nil? || scratch_resources[:all].empty?,
          'Search returned DeviceRequest resources, but none have modifierExtension:doNotPerform=true.'
      end
    end
  end
end
