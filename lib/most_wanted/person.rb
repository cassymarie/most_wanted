
# TYPES = ['Murder','Crimes Against Children','Cyber','White Collar Crimes','Counterintelligence','Human Trafficking','Additional Violent Crimes','Terrorism','Kidnappings & Missing Persons']

class Person

     extend Wanted::ClassMethods
     include Wanted::InstanceMethods

@@attr = ["age", "aliases", "build", "dates_of_birth", "eyes", "hair", "height", "languages", "name", "nationality", "occupations", "path", "place_of_birth", "race", "scars_and_marks", "sex", "status", "title", "uid", "weight"] 

@@all = []



     def self.all 
          @@all
     end

     def self.setup_attributes
          @@attr
     end

     # def make_word_upcase(words)
     #      words.gsub(/\w+/) {|word| word.capitalize}
     # end

     def name_title
          make_word_upcase(self.title)
     end

     # def self.categories
     #      extrct = File.dirname(self.path).match(/wanted\/(.*)/)[1]
     #      extrct.gsub!("-"," ")
     #      # make_words_upcase(extrct)
     #      self.classifications = make_words_upcase(extrct)
     # end



     # def self.list_category(cat)
     #      self.all.select do |person|
     #           person.classification == cat
     #      end
     # end

     # def self.list_classifications
     #      self.all.collect{|person|person.classification}.uniq
     # end

     

     def self.list_names
          self.all.collect do |person|
               person.name
          end
     end
end
