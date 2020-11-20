class Api

TOPICS = {
     topten: 'Top Ten',
     fugitives: {
          cac:'Crimes Against Children',
          murders: 'Murders',
          cyber: 'Cyber',
          wcc: 'White Collar Crimes',
          counterintelligence:'Counterintelligence',
          cei:'Criminal Enterprise Investigations',
          human: 'Human Trafficking',
          additional: "Additional Violent Crimes"},
     terrorism: {
          terrorinfo: 'Seeking Info - Terrorism',
          wanted_terr: 'Most Wanted Terrorist',
          dt: 'Domestic Terrorism'},
     seeking_info: {
          seeking: 'Seeking Info',
          assistance: 'Law Enforcement Assistance'},
     kidnap: 'Kidnap/Missing Persons',
     others: {
          vicap: 'Violent Criminal Apprehension Program',
          parental: 'Parental Kidnappings',
          robbers: 'Known Bank Robbers',
          ecap: 'Endangered Child Alert Program'}
}

@@default_api_wanted = "https://api.fbi.gov/@wanted"
@@total = 0

     def initialize
          @@total = page_parse["total"]
          create_objects
     end

     def page_parse(page_num = 1)
          url = "#{@@default_api_wanted}?page=#{page_num}"
          url = URI(url)
          response = Net::HTTP.get(url)
          full_list = JSON.parse(response)
     end

     def create_objects
          total_pages = ((@@total/20.0)).ceil
          page = 1
          while page <= total_pages do 
               page_parse(page)["items"].each do |criminal|
                   newPerson = Person.new(criminal)
                   newCase = CaseFile.new(criminal)
                   newCase.individual = newPerson
                   newCase.category = newCase.categorize(newPerson)
                   newPerson.name = newPerson.name_title
               end
               page += 1
          end
     end

     def self.total 
          @@total
     end

     def self.main_topics
          TOPICS.collect do |k,v|
               if v.class == String 
                    v
               else  
                    (k.to_s).gsub("_"," ").capitalize 
               end
          end
     end

     def self.sub_topics(topic)
          sub_key = topic.downcase.gsub(" ","_").to_sym
          TOPICS[sub_key].collect {|key,value| value} 
     end

     def self.category_paths
          paths = {}
          TOPICS.each do |k,v|
               if v.class == String
                    paths[k] = v
               elsif v.class == Hash
                    v.each do |k,v|
                         paths[k] = v
                    end
               end
          end
          paths
     end

end
