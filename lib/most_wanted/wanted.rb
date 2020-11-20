module Wanted

     module ClassMethods

          def self.total_att
               attr_by_class = []
               self.all.each do |attr|
                    attr.instance_variables.each {|var| attr_by_class << var unless attr_by_class.include?(var)}
               end
               attr_by_class.sort!{|a,b| a <=> b}
          end

     end

     module InstanceMethods

          def initialize(fbi_hash)

               self.class.setup_attributes.each do |attr|
          
                    self.class.attr_accessor(attr.to_sym)
                    attr2 = case attr
                         when "age","weight","height"
                              "_max"
                         when "eyes", "hair", "race"
                              "_raw"
                         else
                              ""
                    end
                    self.send(("#{attr}="), fbi_hash["#{attr}#{attr2}"])
               end             
               self.class.all << self
          end
          
          def make_word_upcase(words)
               words.gsub(/\w+/) {|word| word.capitalize}
          end
     end
end








