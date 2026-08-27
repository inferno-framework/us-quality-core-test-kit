require_relative '../../../must_support_test'

module USQualityCoreTestKit
  module USQualityCoreV050
    class UsCoreDocumentreferenceMustSupportTest < Inferno::Test
      include USQualityCoreTestKit::MustSupportTest

      title 'All must support elements are provided in the DocumentReference resources returned'

      description %(
        This test will look through the DocumentReference resources
        found previously for the following Must Support and USCDI-flagged elements:

        * DocumentReference.author
        * DocumentReference.category
        * DocumentReference.category:uscore
        * DocumentReference.content
        * DocumentReference.content.attachment
        * DocumentReference.content.attachment.contentType
        * DocumentReference.content.attachment.data
        * DocumentReference.content.attachment.url
        * DocumentReference.content.format
        * DocumentReference.context
        * DocumentReference.context.encounter
        * DocumentReference.context.period
        * DocumentReference.date
        * DocumentReference.identifier
        * DocumentReference.status
        * DocumentReference.subject
        * DocumentReference.type
      )

      id :us_quality_core_v050_us_core_documentreference_must_support_test

      def resource_type
        'DocumentReference'
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:us_core_documentreference_resources] ||= {}
      end

      run do
        perform_must_support_test(all_scratch_resources)
      end
    end
  end
end
