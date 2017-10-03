class Weatherbot::OpenweatherAPI
  attr_accessor :location, :current_weather, :forecast, :response_code, :coordinates, :country, :location_name, :temp_avg, :condition, :cloudiness, :pressure, :humidity, :wind_speed, :wind_direction

  def initialize
    @location = location
    @coodinates = coordinates
    @country = country
  end


  # Takes user input to enter into URL query & gets current weather conditions in imperial units
  def self.current_weather(location)
    # query sample: 'https://api.openweathermap.org/data/2.5/weather?q=new+york&appid=3207703ee5d0d14e6b6a53d10071018f&units=imperial'
    response = HTTParty.get("https://api.openweathermap.org/data/2.5/weather?q=#{location}&appid=3207703ee5d0d14e6b6a53d10071018f&units=imperial")

    parsed_weather = response.parsed_response
    current_conditions = self.new
    current_conditions.response_code = parsed_weather["cod"]

    # Check for invalid entry
    if current_conditions.response_code === "404"
      puts "\n\nInvalid location, please enter a valid location.\n\n"
      return
    else

    current_conditions.coordinates = parsed_weather.fetch("coord").values.reverse
    current_conditions.country = parsed_weather.fetch("sys").fetch("country")
    current_conditions.location_name = parsed_weather.fetch("name")
    current_conditions.temp_avg = parsed_weather.fetch("main")["temp"]
    current_conditions.condition = parsed_weather.fetch("weather").first.fetch("description")
    current_conditions.cloudiness = parsed_weather.fetch("clouds").fetch("all")

    current_conditions.pressure = parsed_weather.fetch("main")["pressure"]

    current_conditions.humidity = parsed_weather.fetch("main")["humidity"]
    current_conditions.wind_speed = parsed_weather.fetch("wind")["speed"]
    wind_deg = parsed_weather.fetch("wind")["deg"]


    # Helper function to convert degrees to direction
    def self.degToCompass(wind_deg)
      val = ((wind_deg / 22.5) + 0.5).floor
      direction_arr = ["N", "NNE", "NE", "ENE", "E", "ESE", "SE", "SSE", "S", "SSW", "SW", "WSW", "W", "WNW", "NW", "NNW"]
      return direction_arr[(val % 16)]
    end

    current_conditions.wind_direction = self.degToCompass(wind_deg)

      puts "\nLocation:         #{current_conditions.location_name}, #{current_conditions.country}\n\n"
      puts "Coordinates:      #{current_conditions.coordinates}"
      puts "Temperature:      #{current_conditions.temp_avg}ºF"
      puts "Condition:        #{current_conditions.condition.capitalize}"
      puts "Cloudiness:       #{current_conditions.cloudiness}%"

      puts "Humidity:         #{current_conditions.humidity}%"
      puts "Wind Speed:       #{current_conditions.wind_speed} mph"
      puts "Wind Direction:   #{current_conditions.wind_direction}"
    end
  end


  # Takes user input to enter into URL query for 5 day / 3 hour forecast in imperial units
  def self.forecast(location)
    # query sample: https://api.openweathermap.org/data/2.5/forecast?q=new+york&appid=3207703ee5d0d14e6b6a53d10071018f&units=imperial")
    response = HTTParty.get("https://api.openweathermap.org/data/2.5/forecast?q=#{location}&appid=3207703ee5d0d14e6b6a53d10071018f&units=imperial")
    @forecast = response.parsed_response
    puts @forecast
  end


  def self.popular_cities
    # List 10 popular cities
    # format: City name, Country Code

    puts "-------------------------------"
    puts ""
    puts "1. London, United Kingdom"
    puts "2. New York City, United States"
    puts "3. Shanghai, China"
    puts "4. Tokyo, Japan"
    puts "5. Berlin, Germany"
    puts "6. Lagos, Nigeria"
    puts "7. Istanbul, Turkey"
    puts "8. Mumbai, India"
    puts "9. Moscow, Russia"
    puts "10. São Paulo, Brazil"
    puts ""
    puts "-------------------------------"


  end

  # Need method to parse current weather conditions


  # Need method to parse 5 day / 3 hour forecast data

end
