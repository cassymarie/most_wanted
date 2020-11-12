module Formatting
PROFILE_WIDTH = 80
PROFILE_SIDE = 16
TITLES = {
     fbi: ['######## ########  ####','##       ##     ##  ## ','##       ##     ##  ## ','######   ########   ## ','##       ##     ##  ## ','##       ##     ##  ## ','##       ########  ####'],
     main_menu: [' __  __   _   ___ _  _   __  __ ___ _  _ _   _ ','|  \/  | /_\ |_ _| \| | |  \/  | __| \| | | | |','| |\/| |/ _ \ | || .` | | |\/| | _|| .` | |_| |','|_|  |_/_/ \_\___|_|\_| |_|  |_|___|_|\_|\___/ '],
     topten: ["___ __  __   ___ __    ",' | /  \|__)   | |_ |\ |',' | \__/|      | |__| \|'],
     fugitives: [' __     __  ___      __ __ ','|_ /  \/ _ | | |\  /|_ (_  ','|  \__/\__)| | | \/ |____) '],
     terroism: ['___ __ __  __  __  __   __     ',' | |_ |__)|__)/  \|__)|(_ |\/| ',' | |__| \ | \ \__/| \ |__)|  | '],
     seeking_Info: [' __ __ __         __         __ __  ','(_ |_ |_ |_/||\ |/ _   ||\ ||_ /  \ ','__)|__|__| \|| \|\__)  || \||  \__/ '],
     kidnap: ['     __          __           __ __      __  ','|_/||  \|\ | /\ |__)    |\/||(_ (_ ||\ |/ _  ','| \||__/| \|/--\|       |  ||__)__)|| \|\__) '],
     others: [' __ ___     __ __  __ ','/  \ | |__||_ |__)(_  ','\__/ | |  ||__| \ __) '],
     search_by: [' __ __     __  __     ','(_ |_  /\ |__)/  |__| ','__)|__/--\| \ \__|  | ']
}

     def clear
          $stdout.clear_screen
     end

     def fbi_title
          puts "#{('*' * PROFILE_WIDTH)}".light_blue
          TITLES[:fbi].each do |line|
               puts text_format_display(line).light_white
          end
          puts text_format_display(('*' * (PROFILE_WIDTH/2))).colorize(:red)
          puts text_format_display("#{('~' * (PROFILE_WIDTH/4))} WANTED LISTS #{('~' * (PROFILE_WIDTH/4))}")
          puts "#{('*' * PROFILE_WIDTH)}".colorize(:light_blue)
     end

     def title_header(title,top_sym = "=", btm_sym = ".", clear_page = true)
          clear if clear_page
          puts "\n#{(top_sym * PROFILE_WIDTH)}".blue
          title.each do |line|
               puts text_format_display(line).light_blue
          end
          puts "#{(btm_sym * PROFILE_WIDTH)}".blue 
     end

     def title_label(label)
          text_format_display(label.upcase.gsub("_"," "))
     end
      

     def text_format_display(display_text, align = "center", padding = 1, space_char = " ")
          display_text = display_text.join(" ") if display_text.class == Array
          len = display_text.length
          space_remain = PROFILE_WIDTH - len
          side = space_remain - (padding * 2)
          ctr = (space_remain - (padding * 4))/2

          case align
          when "left"
               "#{" " * padding}#{display_text}#{" " * padding}#{space_char * side}"
          when "right"
               "#{space_char * side}#{" " * padding}#{display_text}#{" " * padding}"
          when "mid"
               display_text = display_text.split("|")
               "#{" " * padding}#{display_text[0]}#{space_char * side}#{display_text[1]}#{" " * padding}"
          else
               "#{" " * padding}#{space_char * ctr}#{" " * padding}#{display_text}#{" " * padding}#{space_char * ctr}#{" " * padding}"
          end
     end

     def left_side_profile(display_text, align = "center", padding = 1)
          spc1 = PROFILE_SIDE - display_text.length
          spc2 = spc1/2
          display = case align
          when "left"
               "#{(" " * padding)}#{display_text.upcase.gsub("_"," ")}#{(" " * (spc1 - padding))}"
          when "right"
               "#{(" " * (spc1 - padding))}#{display_text.upcase.gsub("_"," ")}#{(" " * padding)}"
          else
               "#{(" " * spc2)}#{display_text.upcase.gsub("_"," ")}#{(" " * spc2)}"
          end
          display.light_white.on_light_black
     end

     def right_side_profile(display_text)
          right_width = (PROFILE_WIDTH - PROFILE_SIDE) + 2
          left_space = PROFILE_SIDE + 2

          wrap_text_profile(display_text, right_width, 2,left_space)
     end

     def wrap_text_profile(display_text, text_width = nil, padding = 2, spacing = 0)
          text_width = PROFILE_WIDTH if text_width.nil?
          display_text = display_text.join(" ") if display_text.class == Array 
          rng_width = text_width - (padding * 2)

               if display_text.to_s.length > rng_width 
                    text_arr = display_text.split(" ")
                    display = "#{' ' * padding}"
                    width = padding

                    text_arr.each do |word|

                         if width + word.length > text_width || width > text_width
                              display += "\n#{' ' * spacing}#{' ' * padding}#{word} "
                              width = padding + spacing
                         else
                              display += "#{word} "
                         end

                         width += (word.length + 1)
                    end
               else
                    display = "#{' ' * padding}#{display_text}"
               end

          display 
     end

     def remove_html_tags(display_text)
          # https://snippets.aktagon.com/snippets/192-removing-html-tags-from-a-string-in-ruby
          remove = /<("[^"]*"|'[^']*'|[^'">])*>/

          display_text = display_text.join(" ") if display_text.class == Array 
          display_text.gsub(remove, '') unless display_text.nil? || display_text.class != String
     end



 end