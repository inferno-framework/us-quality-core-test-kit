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
        add_patient_uscdi_elements
        update_patient_previous_name_address
        remove_practitioner_address
      end      

      def add_must_support_choices
        choices = []

        case profile.type       
        when 'DocumentReference' 
          # https://hl7.org/fhir/us/core/STU9/requirements.html#CONF-0368 
          choices << { paths: ['content.attachment.data', 'content.attachment.url'] }
        when 'Encounter' 
          # https://hl7.org/fhir/us/core/STU9/requirements.html#CONF-0375
          choices << { paths: ['reasonCode', 'reasonReference'] }
          # https://hl7.org/fhir/us/core/STU9/requirements.html#CONF-0379
          choices << { paths: ['location.location', 'serviceProvider'] }
        when 'Goal' 
          # https://hl7.org/fhir/us/core/STU9/requirements.html#CONF-0387
          choices << { paths: ['startDate', 'target.dueDate'] }          
        when 'MedicationRequest'
          # https://hl7.org/fhir/us/core/STU9/requirements.html#CONF-0408
          choices << { paths: ['reportedBoolean', 'reportedReference'] }
          # https://hl7.org/fhir/us/core/STU9/requirements.html#CONF-0411
          choices << {
            paths: ['reasonCode', 'reasonReference'],
            uscdi_plus_quality: true
          }     
        when 'Procedure'
          # https://hl7.org/fhir/us/core/STU9/requirements.html#CONF-0484
          choices << {
            paths: ['reasonCode', 'reasonReference'],
            uscdi_plus_quality: true
          }
        when 'ServiceRequest'
          # https://hl7.org/fhir/us/core/STU9/requirements.html#CONF-0518
          choices << {
            paths: ['reasonCode', 'reasonReference'],
            uscdi_plus_quality: true
          }
        when 'Specimen' 
          # https://hl7.org/fhir/us/core/STU9/requirements.html#CONF-0524
          choices << { paths: ['accessionIdentifier', 'identifier'] }
        end

        must_supports[:choices] = choices if choices.present?        
      end

      def add_patient_uscdi_elements
        return unless profile.type == 'Patient'

        must_supports[:elements].each do |element|
          path = element[:path]

          # Though telecom.system, telecom.value, telecom.use, and communication.language are marked as MustSupport since US Core v4.0.0,
          # their parent elements telecom, and communication are not MustSupport but listed under "Additional USCDI requirements"
          # According to the updated FHIR spec that "When a child element is defined as Must Support and the parent element isn't,
          # a system must support the child if it support the parent, but there's no expectation that the system must support the parent.",
          # We add uscdi_only tag to these elements  
          if path.include?('telecom.') || path.include?('communication.')          
            element[:uscdi_plus_quality] = true
          elsif path == 'deceased[x]'
            # https://hl7.org/fhir/us/core/STU9/requirements.html#CONF-0465
            element[:original_path] = element[:path]
            element[:path] = 'deceasedDateTime'
          end
        end
      end     
      
      # https://hl7.org/fhir/us/core/STU9/requirements.html#CONF-0466
      # https://hl7.org/fhir/us/core/STU9/requirements.html#CONF-0467
      def update_patient_previous_name_address
        return unless profile.type == 'Patient'

        name_period_exists = false
        name_use_exists = false
        address_period_exists = false
        address_use_exists = false

        must_supports[:elements].each do |element|
          case element[:path]
          when 'name.period'
            element[:path] = 'name.period.end'
            element[:uscdi_plus_quality] = true
            name_period_exists = true
          when 'name.use'
            element[:fixed_value] = 'old'
            element[:uscdi_plus_quality] = true
            name_use_exists = true
          when 'address.period'
            element[:path] = 'address.period.end'
            element[:uscdi_plus_quality] = true
            address_period_exists = true
          when 'address.use'
            element[:fixed_value] = 'old'
            element[:uscdi_plus_quality] = true
            address_use_exists = true
          end
        end

        must_supports[:elements] << {
          path: 'name.period.end',
          uscdi_plus_quality: true
        } unless name_period_exists

        must_supports[:elements] << {
          path: 'name.use',
          fixed_value: 'old',
          uscdi_plus_quality: true
        } unless name_use_exists

        must_supports[:elements] << {
          path: 'address.period.end',
          uscdi_plus_quality: true
        } unless address_period_exists

        must_supports[:elements] << {
          path: 'address.use',
          fixed_value: 'old',
          uscdi_plus_quality: true
        } unless address_use_exists

        must_supports[:choices] ||= []

        must_supports[:choices] << {
          paths: ['address.period.end', 'address.use'],
          uscdi_plus_quality: true
        }

        must_supports[:choices] << {
          paths: ['name.period.end', 'name.use'],
          uscdi_plus_quality: true
        }
      end  
      
      # https://hl7.org/fhir/us/core/STU9/requirements.html#CONF-0474
      # https://hl7.org/fhir/us/core/STU9/requirements.html#CONF-0475
      def remove_practitioner_address
        return unless profile.type == 'Practitioner'

        must_supports[:elements].delete_if { |element| element[:path].start_with?('address') }
      end
      
    end
  end
end