# CLI Controller
require 'paint'

class Weatherbot::CLI


  def call
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

  def menu
    input = nil

    while input != "exit"

      puts "\n-------------------------------\n"
      puts "\nPlease enter a specific location in the format:" + Paint[' <location>, <country>', "#D26C22"] + " to check the current weather conditions for that location. You can also search by " + Paint['<location>, <state/region>, <country>', "#D26C22"] + " to find the correct specific location.
      \nType " + Paint['map', "#1E90FF"] + " to open the most relevant result in your OS default browser.
      \n" + Paint['NOTE: ', :red] + "This will open your web browser to the most likely location coordinates in " + Paint['Google Maps.', :italic, :underline]
      puts "\nYou can also type " + Paint['forecast', "#1E90FF"] + " to display the 3 day forecast of the most recent search.
      \nType " + Paint['list', "#1E90FF"] + " to see a list of previous locations. To quit, type " + Paint['exit', "#1E90FF"] + "."
      puts "\n-------------------------------\n"


      input = gets.chomp.downcase

      # Check if user wants to exit
      if input === "exit"
        puts Paint["\n\n\nSee you again soon!\n\n\n", "#808000"]
        exit
      end
      # Check if user wants to enter invalid input before location
      if input === "forecast" || input === "map"
        puts Paint["\n\n\nYou need to input a location first!\n\n\n", :red]
        menu
      end

      # Display current weather
      if input.empty?
        menu
      else
        weather = Weatherbot::API.current_weather(input)
        display_weather(weather)
      end

      new_input = gets.chomp.downcase

      # Check for specific input commands
      if new_input === "exit"
        puts Paint["\n\n\nSee you again soon!\n\n\n", "#808000"]
        exit
      end
      # Display forecast or location map
      if new_input === "forecast"
        Weatherbot::API.forecast(input)
        menu
      elsif new_input === "list"
        display_previous
      elsif new_input === "map"
        Weatherbot::API.open_link
        menu
      else
        input = nil
        menu
      end

      end

  end

  def display_weather(weather)
    puts "\n\nReport Time:      #{weather.report_time}"
    puts "Location:         #{weather.location_name}, #{weather.country}"
    puts "Coordinates:      #{weather.coordinates}"
    puts "Google Maps:      #{weather.google_maps}"
    puts "\nTemperature:      #{weather.temp_avg}ºF / #{weather.temp_celsius}ºC"
    puts "Condition:        #{weather.condition.capitalize}"
    puts "Cloudiness:       #{weather.cloudiness}%"
    puts "\nHumidity:         #{weather.humidity}%"
    puts "Wind Speed:       #{weather.wind_speed} mph"
    puts "Wind Direction:   #{weather.wind_direction}"
    puts "\nSunrise:          #{weather.sunrise}"
    puts "Sunset:           #{weather.sunset}"
  end

  def display_previous
    Weatherbot::API.locations.map { |entry| puts Paint[entry.location_name, "#683A5E"] }
  end


end
