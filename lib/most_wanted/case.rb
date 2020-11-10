
class Case
@@attr = ["individual", "additional_information", "caution", "description", "details", "field_offices", "files", "images", "remarks", "possible_countries", "possible_states", "reward_max", "reward_text", "subjects", "url", "warning_message"]

@@all = []
     
     def self.setup_attributes
         @@attr
     end
     
     def initialize(hash)
          self.class.setup_attributes.each do |attr|
               self.class.attr_accessor(attr.to_sym)
               if attr == "individual" 
                    self.send(("#{attr}="), nil) 
               else 
                    self.send(("#{attr}="), hash["#{attr}"])
               end
          end
          self.class.all << self
     end

     def self.all 
          @@all
     end
     
end
     