class Api

@@default_api_wanted = "https://api.fbi.gov/@wanted"
@@total = 0

     def initialize
          @@total = page_parse["total"]
          create_wanted
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

     def create_wanted
          total_pages = (@@total/20).ceil
          page = 1
          while page <= total_pages do 
               page_parse(page)["items"].each do |criminal|
                    Wanted.new(criminal)
               end
               page += 1
          end
     end


end
