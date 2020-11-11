
class MostWanted::CLI
TYPES = ['Murder','Crimes Against Children','Cyber','White Collar Crimes','Counterintelligence','Human Trafficking','Additional Violent Crimes','Terrorism','Kidnappings & Missing Persons']


     def start
          welcome
          about
          Api.new
          # binding.pry
          list_main_menu
          user_selection
          
     end

     def welcome
          puts "\n****************************************".colorize(:blue)
          puts "        _______ ______  _____".colorize(:white)
          puts "        |______ |_____]   |  ".colorize(:white)
          puts "        |       |_____] __|__".colorize(:white)     
          puts "\n    ------------------------------".colorize(:red)
          puts "         ~~~ WANTED LISTS ~~~  ".colorize(:white)
          puts "****************************************\n".colorize(:blue)
     end

     def about
          saying = "At Most Wanted, you can view information about all the individuals that the FBI are looking for. \nUse the prompts to navigate through the different offenders and victims."
          count = 0
          saying.split(' ').each {|word|
               if count > 40 
                    count = 0
                    puts " "
               elsif count == -1
                    puts "\n\n"
                    count = 0
               end

               print "#{word} "

               if word.include?(".") 
                    count = -1
               else
                    count += (word.length + 1) 
               end

               sleep(0.2)
          }
     end

     def list_main_menu

          puts "\n________________________________________".colorize(:red) 
          puts "_  _ ____ _ _  _    _  _ ____ _  _ _  _".colorize(:blue)     
          puts "|\\/| |__| | |\\ |    |\\/| |___ |\\ | |  |".colorize(:blue) 
          puts "|  | |  | | | \\|    |  | |___ | \\| |__|".colorize(:blue)
          puts "________________________________________\n".colorize(:red) 


          TYPES.each_with_index do |type, i|
               puts "   #{i+1}".colorize(:green) + ". #{type}"
          end
          puts "\n [" + "exit".colorize(:green) + "] to leave the Most Wanted List"
     end

     def user_selection
          puts "\nEnter the select to view more info..."
          user_input = gets.strip.colorize(:light_blue ).colorize( :background => :red)
          input_idx = user_input.to_i
          if input_idx > 0 && user_input != 'exit'
               case input_idx
               when 1
                    list_wanted
               when 2..TYPES.size
                    puts "You choose: #{TYPES[input_idx -1]}"
               else
                    adios
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
