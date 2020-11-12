
class CaseFile 

extend Wanted::ClassMethods
include Wanted::InstanceMethods

@@attr = ["individual", "additional_information", "caution", "description", "details", "files", "images", "remarks", "possible_countries", "possible_states", "reward_max", "reward_text", "field_offices", "subjects", "url", "warning_message"]
attr_accessor :category

@@all = []

     def self.setup_attributes
         @@attr
     end

     def self.all 
          @@all
     end

     def individual=(person)
          @individual = person.class != Person ? nil : person
     end

     def categorize(person)
          extrct = File.dirname(person.path).match(/wanted\/(.*)/)[1]
          Api.category_paths.each {|key,value|
               if extrct.include?(key.to_s)
                    return value
               end
          }
     end

     def self.field_offices
          ((self.all.collect {|file| file.field_offices}.compact).flatten).sort{|a,b| a <=> b}.uniq
     end

     def self.find_by_office(city)
          city = (city.downcase).gsub(" ","")
          puts city

          if self.field_offices.include?(city)
               self.all.select do |file|
                    file.field_offices.any?(city) unless file.field_offices.nil?
               end
          else
               puts "I'm sorry, that city is not listed"
          end
     end

     def self.find_by_category(list)
          self.all.select do |file|
               file.category == list
          end
     end

end
