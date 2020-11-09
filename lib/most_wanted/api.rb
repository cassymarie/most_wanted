class MostWanted::Api

     def fetch_wanted
          url = "https://api.fbi.gov/@wanted"
          url = URI(url)
          response = Net::HTTP.get(url)
          full_list = JSON.parse(response)
          full_list["items"]
     end

     def create_wanted
          fetch_wanted.each do |criminal|
               Wanted.new(criminal)
          end
     end

end
