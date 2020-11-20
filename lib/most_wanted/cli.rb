
class MostWanted::CLI

     include Formatting

     def start
          clear
          fbi_title
          about
          Api.new
          display_main_menu
     end

     def about
          saying = "Welcome to FBI's Most Wanted.  Users can view the profile information about the individuals that the FBI are looking for based on the different crime categories.  Use the keys listed to navigate through the menus, and profiles of the offenders and victims."
          count = 0

          saying.split(' ').each do |word|

               if count > PROFILE_WIDTH || (count + word.length) > PROFILE_WIDTH || count == -1
                    count = 0
                    puts " "
               end

               word == 'keys' ? print("#{word} ".green) : print("#{word} ")

               count += (word.length + 1) 
               sleep(0.25)

               if word.include?(".") 
                    count = -1
                    puts ""
                    sleep(0.5)
               end
          end
     end

     #Display Menus & Profile
     def display_main_menu(clear_screen = false)
          clear if clear_screen
          title_header(TITLES[:main_menu],"_","-",false)

          Api.main_topics.each_with_index do |type, i|
               puts "#{(" " * (PROFILE_SIDE / 2))}#{i+1}".green + ". #{type}"        
          end

          puts "\n NAVIGATE: ".black.on_green + " #{nav_main}".on_black
          input_menu
     end

     def display_sub_menu(topic)
          clear     
          key = topic_key(topic)

          #creates title
          title_header(TITLES[key],"~",".",true)
          puts ""

          #numbered list - second level
          Api.sub_topics(topic).each_with_index do |type, i|
               puts "   #{i+1}".green + ". #{type}"
          end

          puts "\n NAVIGATE: ".black.on_green + " #{nav_main(topic)}".on_black
          input_menu(topic)
     end

     def display_profile(topic, title, idx = 1, sub_heading = nil)

          title_header(title, "~", ".", true)
          puts text_format_display(sub_heading).white.on_blue.bold unless sub_heading.nil?

          if sub_heading.nil? 
               search_category = topic
          else
               search_category = sub_heading
          end

          search_arr = CaseFile.find_by_category(search_category)

          total = search_arr.compact.size
          display_idx = idx - 1

          if total == 0 || idx > total

               saying = "Good News!!! There are 0 #{search_category} Profiles to display" if total == 0
               saying = "You have reached the End of the #{search_category} Profiles." if idx > total

               puts ""
               puts "#{text_format_display(saying)}\n\n".red.bold
               puts ""
               sleep(2.5)

               search_category == topic ? display_main_menu(true) : display_sub_menu(topic)

          else 

               display_recordbar(search_category,idx,total)

               person = search_arr[display_idx].individual
               casefile = search_arr[display_idx]
               warning = casefile.warning_message

               puts "#{text_format_display(warning)}".light_white.on_red.bold unless warning.nil?
               person_display(person)
               casefile_display(casefile)

               puts "\n NAVIGATE: ".black.on_green + " #{nav_profile(idx, total, casefile, topic, sub_heading)}".on_black
               input_profile(topic, idx, sub_heading, casefile)
          end  
     end

     def person_display(person)
          hide_info = ['path','uid','title']
          
          puts "#{title_label(person.title)}\n".red.on_light_white

          person.instance_variables.each do |att_name|
               label = att_name.match(/([^@]\w*)/)[1]
               value = remove_html_tags(person.instance_variable_get(att_name))
               puts "#{left_side_profile(label,"right")}  #{right_side_profile(value)}" unless value.nil? || hide_info.include?(label)
          end
          
          puts ""
     end
     
     def casefile_display(casefile)
          hide_info = ['individual','files','images','subjects','url','category','warning_message']
          casefile.instance_variables.each do |att_name|
               label = att_name.match(/([^@]\w*)/)[1]
               value = remove_html_tags(casefile.instance_variable_get(att_name))

               if !value.nil? && !hide_info.include?(label) && value != 0
                    label = label.upcase.gsub("_"," ")
                    case label
                    when 'CAUTION', 'REMARKS'
                         puts "#{text_format_display(label)}".light_white.on_red.bold
                         puts wrap_text_profile(value)
                    else
                         label = "ADDITIONAL INFO" if label == "ADDITIONAL INFORMATION"
                         puts "#{left_side_profile(label,"left")}".black.on_light_red + "#{right_side_profile(value)}"
                    end
                    puts ""
               end
          end
     end

     def display_recordbar(topic,idx=1, total)
          if topic == "Top Ten"
               bar = "VIEWING: #{idx} of #{total}"
          else
               bar = "TOTAL: #{total} #{topic}  |  VIEWING: #{idx} of #{total}"
          end
          puts "#{text_format_display(bar,"mid")}\n".black.on_light_blue  
     end

     #User input menu/profile - Valid checke
     def input_menu(topic = "main", sub_heading = nil)
          user_input = ""

          #(Loop) Valid input received
          until valid_menu?(user_input, topic) do
               print "\n Type Option: ".green 
               print "  "
               user_input = gets.strip.downcase
          end

          title_goodbye if user_input == "exit"

          if user_input == 'menu'
               clear
               fbi_title
               display_main_menu
           end

          input_idx = user_input.to_i
          if input_idx > 0    #MAIN MENU / SUB-MENU INPUT (NUMBER ONLY)
               if topic == "main"
                    topic = Api.main_topics[(input_idx - 1)].to_s
                    case input_idx
                    when 1
                         display_profile(topic,TITLES[:topten],1)
                    when 5
                         key = Api::TOPICS.key(topic)
                         display_profile(topic,TITLES[key],1)
                    else
                         display_sub_menu(topic)
                    end
               else  #sub-menu / next list (number selection)
                    sub_topic = Api.sub_topics(topic)[input_idx - 1]
                    display_profile(topic, TITLES[topic_key(topic)], 1, sub_topic)
               end
          end
     end

     def valid_menu?(input, topic = "main")
          valid = false
          text_entry = ['exit','menu']

          valid = text_entry.any?(input)

          max_num = case topic
                    when 'main'
                         Api.main_topics.count
                    else
                         Api.sub_topics(topic).count
                    end

          input_num = input.to_i          
          valid = true if input_num > 0 && input_num <= max_num 
          valid
     end

     def input_profile(topic, idx = 1, sub_topic = nil, casefile = nil)
          user_input = ""

          until valid_profile?(user_input, topic, idx, sub_topic, casefile) do
               print "\n Type Option: ".green 
               print "  "
               user_input = gets.strip.downcase
          end

          # title_goodbye if user_input == "exit"

               key = topic_key(topic) 
               key = :topten if topic == 'Top Ten'
               key = :kidnap if topic == 'Kidnap/Missing Persons'
               
               display_profile(topic,TITLES[key], (user_input.to_i), sub_topic) unless user_input.to_i == 0

               case user_input
                    when 'n'
                         display_profile(topic,TITLES[key], (idx + 1), sub_topic)
                    when 'p'
                         display_profile(topic,TITLES[key], (idx - 1), sub_topic)
                    when 'view'
                         system("open", casefile.url)
                         input_profile(topic, idx, sub_topic, casefile)
                    when 'back'
                         display_sub_menu(topic)
                    when 'menu'
                         clear
                         fbi_title
                         display_main_menu
                    when 'exit'
                         title_goodbye
                    # else
                    #      clear
                    #      fbi_title
                    #      display_main_menu
               end

     end

     def valid_profile?(input, topic, idx = 1, sub_topic = nil, casefile)
          valid = false
          text_entry = ['exit','menu','back','view','n','p']
          input_num = input.to_i
          
          if topic == 'Top Ten' || topic == 'Kidnap/Missing Persons'
               max_num = CaseFile.category_total(topic)
          else
               max_num = CaseFile.category_total(sub_topic)
          end  

          if input.length == 1 && input == 'n' || input == 'p'
     
               valid = true if input == 'n' && max_num >= idx
               valid = true if input == 'p' && idx != 1
               
          elsif input.length > 1 && text_entry.include?(input)
               valid = true if input == 'back' && !sub_topic.nil?
               valid = true if input == 'exit' || input == 'menu'
               valid = true if input == 'view' && !casefile.url.nil?
          elsif input_num = input.to_i > 0 && input_num <= max_num
               valid = true
          end
          valid
     end
end