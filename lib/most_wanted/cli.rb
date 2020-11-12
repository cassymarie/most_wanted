
class MostWanted::CLI

     include Formatting

     def start
          # title_header(TITLES.fbi,)
          fbi_title
          about
          Api.new
          # binding.pry
          list_main_menu
          user_selection
     end


     def about
          saying = "At Most Wanted, you can view information about all the individuals that the FBI are looking for. Use the prompts to navigate through the different offenders and victims."
          count = 0
          saying.split(' ').each {|word|

               if count > PROFILE_WIDTH || (count + word.length) > PROFILE_WIDTH 
                    count = 0
                    puts " "
               elsif count == -1
                    puts "\n\n"
                    count = 0
               end

               if word == 'prompts'  
                    print "#{word} ".green
               else
                    print "#{word} "
               end

               if word.include?(".") 
                    count = -1
                    # sleep(0.75)
               else
                    count += (word.length + 1) 
                    # sleep(0.25)
               end
          }
          # puts ""
     end

     def list_main_menu
          title_header(TITLES[:main_menu],"_","-",false)

          Api.main_topics.each_with_index do |type, i|
               puts "   #{i+1}".green + ". #{type}"
          end

          puts "\n [" + "exit".green + "] to leave the Most Wanted List"
     end

     def user_selection
          puts "\nEnter the select to view more info..."
          user_input = gets.strip
          input_idx = user_input.to_i

          if input_idx > 0 && user_input != 'exit'
               
               topic = Api.main_topics[input_idx-1].to_s
               title_key = Api::TOPICS.key(topic)
               display_profile(topic,TITLES[title_key])
               
          elsif user_input == 'exit'
               adios
          end
     end

     def display_recordbar(topic,idx = 1, total)
          if topic == "Top Ten"
               bar = "VIEWING: #{idx} of #{total}"
          else
               bar = "TOTAL: #{total} #{topic}  |  VIEWING: #{idx} of #{total}"
          end
          puts "#{text_format_display(bar,"mid")}\n".black.on_light_blue  
     end

     def display_profile(topic,title,idx = 1)
          title_header(title,"~",".",true)
          search_arr = CaseFile.find_by_category(topic)
          total = search_arr.compact.size
          display_idx = idx - 1

          if total == 0
               puts " Good News!!! There are 0 #{topic} Profiles to display"
               sleep(2.0)
               list_main_menu
          else 
               display_recordbar(topic,idx,total)
               person = search_arr[display_idx].individual
               casefile = search_arr[display_idx]
               warning = casefile.warning_message
               puts "#{text_format_display(warning)}\n".light_white.on_red.bold.blink unless warning.nil?

               person_display(person)
               casefile_display(casefile)

               puts "#{nav_menu(idx, total, casefile)}"
          end  

          
     end

     def person_display(person)
          hide_info = ['aliases','path','uid','title']
          
          puts "#{title_label(person.title)}".red.on_light_white
          puts "#{text_format_display(wrap_text_profile(person.aliases))}".red.on_light_white.italic
          puts ""

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
                    when 'CAUTION'
                         puts "#{text_format_display(label)}".light_white.on_red.bold
                         puts wrap_text_profile(value)
                    else
                         puts "#{left_side_profile(label,"right")}".black.on_light_red + "#{right_side_profile(value)}"
                    end
                    puts ""
               end
          end
     end


     def nav_options(page=1,topic)  
          options = ['next','prev','menu','exit']
          puts "\n Navigate: [next] Next 20, [prev] Prev 20, [menu] main menu, [exit] exit"
          user_input = gets.strip
          if options.include?(user_input)
               case user_input
               when 'next'
                    list_wanted((page + 1),topic)
               when 'prev'
                    if page == 1 
                         puts "going back to main menu"
                    else
                         list_wanted(page =+1,topic)
                    end
               when 'menu'
                    welcome
               when 'exit'
                    adios
               else
                    welcome
               end
          end
     end

     
     def nav_menu(cur_record = 1, total, obj)

          puts "#{text_format_display("NAVIGATE: ","left")}".black.on_green
          
          prev_rec = ""
          prev_rec = "[" + "<".green + "] Previous Record  " unless cur_record == 1

          next_rec = ""
          next_rec = "[" + ">".green + "] Next Record  " unless cur_record == total
          
          view_url = ""
          view_url = "[" + "view".green + "] View more Info  " unless obj.url.nil?

          menu = "[" + "menu".green + "] Back to Menu  "
          exit_cli = "[" + "exit".green + "] Exit Program"

          wrap_text_profile("#{prev_rec}#{next_rec}#{view_url}#{menu}#{exit_cli}")
     end

     def nav_profile()

     end



     def adios
          puts "\nSee you on the flip side."
     end





end
