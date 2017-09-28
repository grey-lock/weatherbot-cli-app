# CLI Controller

class Weatherbot::CLI

  def call
    puts "
           ___      _______  _______  ______   ___   __    _  _______
          |   |    |       ||   _   ||      | |   | |  |  | ||       |
          |   |    |   _   ||  |_|  ||  _    ||   | |   |_| ||    ___|
          |   |    |  | |  ||       || | |   ||   | |       ||   | __
          |   |___ |  |_|  ||       || |_|   ||   | |  _    ||   ||  | ___   ___   ___
          |       ||       ||   _   ||       ||   | | | |   ||   |_| ||   | |   | |   |
          |_______||_______||__| |__||______| |___| |_|  |__||_______||___| |___| |___|

          "
    # sleep(1)

    # puts "
    #
    #
    #        ____   ____   ____   ____   ____   ____   ____   ____   ____   ____   ____   ____   ____   ____
    #       |____| |____| |____| |____| |____| |____| |____| |____| |____| |____| |____| |____| |____| |____|
    #
    #
    #
    #
    #       "
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
    puts ""
    puts "I'm a command line interface Ruby gem that gives you up to the minute weather for any location in the world!"
    puts ""
  end

  def list_popular_cities
    puts ""
    puts "Choose from the list of cities below:"
    puts ""
    # list popular cities
    @cities = Weatherbot::OpenweatherAPI.popular_cities
  end

  def menu
    input = nil

    list_popular_cities

    while input != "exit"

      puts "-------------------------------"
      puts ""
      puts "You can select from popular cities above by typing 1-10, or enter a location in the format: <city>, <country> to check the current weather conditions for that location. You can also type 'list' to display a list of popular cities' current weather. To quit, type 'exit."
      puts ""
      puts "-------------------------------"

      input = gets.strip.downcase
      # Pass the input into the HTTParty API call
      Weatherbot::OpenweatherAPI.query(input) # This works!

      case input
      when "1" # Stub for 1st item
          input = "london"
          puts "-------------------------------"
          puts ""
          puts "London, United Kingdom current weather"
          puts ""
          puts "-------------------------------"
        when "2" # Stub for 2nd item
          puts "-------------------------------"
          puts ""
          puts "New York City, United States current weather"
          puts ""
          puts "-------------------------------"
        when "3" # Stub for 3rd item
          puts "-------------------------------"
          puts ""
          puts "Shanghai, China current weather"
          puts ""
          puts "-------------------------------"
        when "list" # This works
          list_popular_cities
        when
          puts
        when "exit" # This works
          puts ""
          puts "See you again soon!"
          puts ""
        else
          # Need method here to check for invalid response from API
          "Invalid entry, please enter a valid location."
        end
      end

  end


end
