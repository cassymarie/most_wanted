
class MostWanted::CLI
TYPES = ['Murder','Crimes Against Children','Cyber','White Collar Crimes','Counterintelligence','Human Trafficking','Additional Violent Crimes','Terrorism','Kidnappings & Missing Persons']

     def call
          Api.new
          puts "Welcome to FBI Most Wanted list"
          puts "--------------------------------\n"
          list_main_menu
          user_selection
     end

     def list_main_menu
          TYPES.each_with_index do |type, i|
               puts "#{i+1}. #{type}"
          end
          puts "\n 'exit' - Will leave the Most Wanted."
     end

     def user_selection
          puts "Enter the number of the criminals you want to view..."
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

     def list_wanted
          Wanted.list_names.each_with_index do |each, i|
               puts "#{i+1}. #{each}"
          end
     end

     def adios
          puts "See you on the flip side."
     end


end
