module USQualityCoreTestKit
  class Generator
    class MustSupportMetadataExtractorV1
      attr_accessor :profile, :must_supports

      def initialize(profile, must_supports)
        self.profile = profile
        self.must_supports = must_supports
      end

      def handle_special_cases
        add_must_support_choices
      end      

      def add_must_support_choices
        choices = []

        case profile.type       
        when 'DocumentReference' # https://hl7.org/fhir/us/core/STU9/StructureDefinition-us-core-documentreference.html
          choices << { paths: ['content.attachment.data', 'content.attachment.url'] }
        when 'Encounter' # https://hl7.org/fhir/us/core/STU9/StructureDefinition-us-core-encounter.html
          choices << { paths: ['reasonCode', 'reasonReference'] }
          choices << { paths: ['location.location', 'serviceProvider'] }
        when 'Goal'
          choices << { paths: ['startDate', 'target.dueDate'] }          
        when 'MedicationRequest'
          choices << { paths: ['reportedBoolean', 'reportedReference'] }
          choices << {
            paths: ['reasonCode', 'reasonReference'],
            uscdi_only: true
          }          
        when 'Specimen' # https://hl7.org/fhir/us/core/STU9/StructureDefinition-us-core-specimen.html
          choices << { paths: ['accessionIdentifier', 'identifier'] }
        end

        must_supports[:choices] = choices if choices.present?        
      end
    end
  end
end