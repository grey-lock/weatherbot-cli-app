class Weatherbot::OpenweatherAPI
  attr_accessor :location, :current_weather, :forecast, :response_code

  def initialize
    @location = location
  end


  # Takes user input to enter into URL query & gets current weather conditions in imperial units
  def self.current_weather(location)
    # query sample: 'https://api.openweathermap.org/data/2.5/weather?q=new+york&appid=3207703ee5d0d14e6b6a53d10071018f&units=imperial'
    response = HTTParty.get("https://api.openweathermap.org/data/2.5/weather?q=#{location}&appid=3207703ee5d0d14e6b6a53d10071018f&units=imperial")
    @current_weather = response.parsed_response

    response_code = @current_weather["cod"]

    if response_code === "404"
      puts "\n\nInvalid location, please enter a valid location.\n\n"
      return
    else

    coordinates = @current_weather.fetch("coord").values.reverse
    condition = @current_weather.fetch("weather").first.fetch("description")
    temp_avg = @current_weather.fetch("main")["temp"]
    pressure = @current_weather.fetch("main")["pressure"]
    humidity = @current_weather.fetch("main")["humidity"]
    wind_speed = @current_weather.fetch("wind")["speed"]
    wind_direction = @current_weather.fetch("wind")["deg"]

      puts "\nLocation:         #{location.capitalize}\n\n"
      puts "Coordinates:      #{coordinates}"
      puts "Condition:        #{condition.capitalize}"
      puts "Temperature:      #{temp_avg}ºF"
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
