class Wanted
@@all = []
@@attr = []

     def initialize(attributes)
          attributes.each do |key, value| 
              key = "wanted_id" if key == "@id"
          self.class.attr_accessor(key.to_sym)
          self.send(("#{key}="), value)
          end
          self.class.all << self
     end

     def self.list_names
          self.all.collect do |bad_guy|
               bad_guy.title.split(' ').collect{|x| x.downcase}.collect{|x| x.capitalize}.join(' ')
          end
     end

     def self.classifications
          self.all.collect {|person| person.person_classificaiton}.uniq
     end

     def self.total_att
          self.all.each do |attr|
               attr.instance_variables.each {|var| @@attr << var unless @@attr.include?(var)}
          end
          @@attr.sort!{|a,b| a <=> b}
     end

     def self.all
          @@all
     end

     def self.attributes
          @@attr
     end
end
