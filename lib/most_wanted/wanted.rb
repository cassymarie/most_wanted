class Wanted
@@all = []

     def initialize(attributes)
          attributes.each do |key, value| 
              key = "wanted_id" if key == "@id"
          self.class.attr_accessor(key)
          self.send(("#{key}="), value)
          end
          self.class.all << self
     end

     def self.list_names
          self.all.collect do |bad_guy|
               bad_guy.title.split(' ').collect{|x| x.downcase}.collect{|x| x.capitalize}.join(' ')
          end
     end

     def self.all
          @@all
     end
end
