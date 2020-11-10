
class MostWanted::CLI
TYPES = ['Murder','Crimes Against Children','Cyber','White Collar Crimes','Counterintelligence','Human Trafficking','Additional Violent Crimes','Terrorism','Kidnappings & Missing Persons']

     def start
          Api.new
          welcome
     end

     def welcome

          puts "\n-----------------------------------"
          puts "   **** FBI Wanted Lists ****"
          puts "-----------------------------------\n\n"

          list_main_menu
          user_selection
     end


     def list_main_menu
          TYPES.each_with_index do |type, i|
               puts "#{i+1}. #{type}"
          end
          puts "\n [exit] to leave the Most Wanted List"
     end

     def user_selection
          puts "\nEnter the number to view the list..."
          user_input = gets.strip
          input_idx = user_input.to_i
          if input_idx > 0 && user_input != 'exit'
               case input_idx
               when 1
                    list_wanted
               when 2..TYPES.size
                    puts "You choose: #{TYPES[input_idx -1]}"
               end
          elsif user_input == 'exit'
               adios
          end
     end

     def list_wanted(page=1)
          to = page*20
          from = to-19
          index = from -1
          puts "\n Wanted Murders [Page: #{page} | #{from} - #{to})]"
          while from <= to
               puts "   #{from}. #{Person.list_names[from-1]}"
               from +=1
          end
          nav_options(page)
     end

     def nav_options(page=1)
          options = ['next','prev','menu','exit']
          puts "\n Navigate: [next] Next 20, [prev] Prev 20, [menu] main menu, [exit] exit"
          user_input = gets.strip
          if options.include?(user_input)
               case user_input
               when 'next'
                    list_wanted((page + 1))
               when 'prev'
                    if page == 1 
                         puts "going back to main menu"
                    else
                         list_wanted(page =+1)
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

     def adios
          puts "\nSee you on the flip side."
     end


end
