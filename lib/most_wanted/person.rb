class Person

extend Wanted::ClassMethods
include Wanted::InstanceMethods

@@attr = ["age", "build", "dates_of_birth", "eyes", "hair", "height", "languages", "name", "aliases", "nationality", "occupations", "path", "place_of_birth", "race", "scars_and_marks", "sex", "status", "title", "uid", "weight"] 

@@all = []

     def self.all 
          @@all
     end

     def self.setup_attributes
          @@attr
     end

     def name_title
          make_word_upcase(self.title)
     end
    
     def self.list_names
          self.all.collect do |person|
               person.name
          end
     end

end
