
class Person
@@attr = ["age", "aliases", "build", "dates_of_birth", "eyes", "hair", "height", "languages", "name", "nationality", "occupations", "path", "classification", "place_of_birth", "race", "scars_and_marks", "sex", "status", "title", "uid", "weight"]
@@all = []

     def self.setup_attributes
         @@attr
     end

     def initialize(hash)
          
          self.class.setup_attributes.each do |attr|
          
               self.class.attr_accessor(attr.to_sym)

               case attr
               when "age","weight","height"
                    self.send(("#{attr}="), hash["#{attr}_max"])
               when "eyes", "hair", "race"
                    self.send(("#{attr}="), hash["#{attr}_raw"])
               else
                    self.send(("#{attr}="), hash["#{attr}"])
               end
          end
          self.class.all << self
     end

     def self.all 
          @@all
     end


     def self.list_names
          self.all.collect do |bad_guy|
               bad_guy.title.split(' ').collect{|x| x.downcase}.collect{|x| x.capitalize}.join(' ')
          end
     end
end
