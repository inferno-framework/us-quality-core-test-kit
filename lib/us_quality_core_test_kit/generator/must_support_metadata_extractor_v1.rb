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
        when 'DocumentReference' 
          choices << { paths: ['content.attachment.data', 'content.attachment.url'] }
        when 'Encounter' 
          choices << { paths: ['reasonCode', 'reasonReference'] }
          choices << { paths: ['location.location', 'serviceProvider'] }
        when 'Goal' 
          choices << { paths: ['startDate', 'target.dueDate'] }          
        when 'MedicationRequest'
          choices << { paths: ['reportedBoolean', 'reportedReference'] }
          choices << {
            paths: ['reasonCode', 'reasonReference'],
            uscdi_plus_quality: true
          }     
        when 'Patient'
          choices << {
            paths: ['address.period.end', 'address.use'],
            uscdi_plus_quality: true
          }
          choices << {
            paths: ['name.period.end', 'name.use'],
            uscdi_plus_quality: true
          }
        when 'Procedure'
          choices << {
            paths: ['reasonCode', 'reasonReference'],
            uscdi_plus_quality: true
          }
        when 'ServiceRequest'
          choices << {
            paths: ['reasonCode', 'reasonReference'],
            uscdi_plus_quality: true
          }
        when 'Specimen' 
          choices << { paths: ['accessionIdentifier', 'identifier'] }
        end

        must_supports[:choices] = choices if choices.present?        
      end
    end
  end
end