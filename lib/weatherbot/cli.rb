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
    sleep(2)


    puts "


           ____   ____   ____   ____   ____   ____   ____   ____   ____   ____   ____   ____   ____   ____
          |____| |____| |____| |____| |____| |____| |____| |____| |____| |____| |____| |____| |____| |____|




          "
    sleep(2)



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

    sleep(2)

    intro
    menu
    list_popular_cities
  end

  def intro
    puts ""
    puts "I'm a command line interface Ruby gem that gives you up to the minute weather for any location in the world!"
    puts ""
  end

  def list_popular_cities
    puts ""
    puts "London, United Kingdom"
    puts "New York City, United States"
    puts "Shanghai, China"
    puts "Tokyo, Japan"
    puts "Berlin, Germany"
    puts "Lagos, Nigeria"
    puts "Istanbul, Turkey"
    puts "Mumbai, India"
    puts "Moscow, Russia"
    puts "São Paulo, Brazil"
    puts ""
  end

  def menu
    input = nil
    puts ""
    puts "You can select from popular cities below, or enter a location in the format: <city>, <country>, to check the current weather conditions for that location. Or type 'exit' to quit."
    puts ""
  end


end
