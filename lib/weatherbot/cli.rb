# CLI Controller

class Weatherbot::CLI

  def call
    sleep(1)
    puts "
           __   __  ___           ___   __   __   __
          |  | |  ||   |         |   | |  | |  |_|  |
          |  |_|  ||   |         |   | |__| |       |
          |       ||   |         |   |      |       |
          |       ||   |  ___    |   |      |       |
          |   _   ||   | |_  |   |   |      | ||_|| |
          |__| |__||___|   |_|   |___|      |_|   |_|
           _     _  _______  _______  _______  __   __  _______  ______    _______  _______  _______  __
          | | _ | ||       ||   _   ||       ||  | |  ||       ||    _ |  |  _    ||       ||       ||  |
          | || || ||    ___||  |_|  ||_     _||  |_|  ||    ___||   | ||  | |_|   ||   _   ||_     _||  |
          |       ||   |___ |       |  |   |  |       ||   |___ |   |_||_ |       ||  | |  |  |   |  |  |
          |       ||    ___||       |  |   |  |       ||    ___||    __  ||  _   | |  |_|  |  |   |  |__|
          |   _   ||   |___ |   _   |  |   |  |   _   ||   |___ |   |  | || |_|   ||       |  |   |   __
          |__| |__||_______||__| |__|  |___|  |__| |__||_______||___|  |_||_______||_______|  |___|  |__|

          "

    sleep(1)

    intro
    menu
  end

  def intro
    puts "\n\nI'm a command line interface Ruby gem that gives you current and forecast weather for any location in the world!\n\n"
  end

  # def list_popular_cities
  #   puts ""
  #   puts "Choose from the list of cities below:"
  #   puts ""
  #   # list popular cities
  #   @cities = Weatherbot::OpenweatherAPI.popular_cities
  # end

  def menu
    input = nil

    # list_popular_cities

    while input != "exit"

      puts "\n-------------------------------\n"
      puts "\nPlease enter a specific location in the format: <location>, <country> to check the current weather conditions for that location. You can also search by <location>, <state>, <country>, OR  <zipcode>, US, to find the correct specific location.
      \nType 'map' to open the most relevant result in your OS default browser.
      \n*NOTE: This will open your web browser to the most likely location coordinates in Google Maps.*
      \nYou can also type 'forecast' to display the 3 day forecast of the most recent search. To quit, type 'exit'.\n"
      puts "\n-------------------------------\n"

      input = gets.chomp.downcase

      # Check if user wants to exit
      if input === "exit"
        puts "\n\n\nSee you again soon!\n\n\n"
        exit
      end

      Weatherbot::OpenweatherAPI.current_weather(input)

      new_input = gets.chomp.downcase

      if new_input === "forecast"
        Weatherbot::OpenweatherAPI.forecast(input)
      elsif new_input === "map"
        Weatherbot::OpenweatherAPI.open_link
      end


      # Pass the input (location) into the API call for current weather
      # valid_response(input)

      # case input
      #   # when "1" # Stub for 1st item
      #   #   input = "london"
      #   #   puts "\n\n\nLondon, United Kingdom current weather\n\n\n"
      #   # when "2" # Stub for 2nd item
      #   #   puts "\n\n\nNew York City, United States current weather\n\n\n"
      #   # when "3" # Stub for 3rd item
      #   #   puts "\n\n\nShanghai, China current weather\n\n\n"
      #   when "forecast"
      #     Weatherbot::OpenweatherAPI.forecast(input)
      #   when "list" # This works
      #     list_popular_cities
      #   else
      #     # Need method here to check for error response from API
      #
      #   end
      end

  end

  # Check if input returns a valid location
  def valid_response(input)
    if @response_code === "200"
      puts @current_weather
    else
      puts "Invalid entry, please enter a valid location."
      menu
    end
  end

end
