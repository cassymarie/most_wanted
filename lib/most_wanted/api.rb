class Api

CATEGORIES = {
     cac:'Crimes Against Children', 
     counterintelligence:'Counterintelligence', 
     cei:'Criminal Enterprise Investigations', 
     cyber: 'Cyber', 
     dt: 'Domestic Terrorism', 
     ecap: 'Endangered Child Alert Program', 
     human: 'Human Trafficking', 
     kidnap: 'Kidnapping/Missing Persons', 
     robbers: 'Known Bank Robbers',
     assistance: 'Law Enforcement Assistance', 
     murders: 'Murders', 
     parental: 'Parental Kidnappings', 
     seeking: 'Seeking Info', 
     terror: 'Terrorism', 
     topten: 'Top Ten', 
     vicap: 'Violent Criminal Apprehension Program', 
     wcc: 'White Collar Crimes'}

@@default_api_wanted = "https://api.fbi.gov/@wanted"
@@total = 0

     def initialize
          @@total = page_parse["total"]
          create_objects
     end

     def self.total 
          @@total
     end

     def page_parse(page_num = 1)
          url = "#{@@default_api_wanted}?page=#{page_num}"
          url = URI(url)
          response = Net::HTTP.get(url)
          full_list = JSON.parse(response)
     end

     def create_objects
          total_pages = ((@@total/20.0)/2.0).ceil
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


end
