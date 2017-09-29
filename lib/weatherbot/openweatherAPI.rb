class Weatherbot::OpenweatherAPI
  attr_accessor :location, :current_weather, :forecast

  def initialize
    @location = location
  end

  # Takes user input to enter into URL query for current weather conditions in imperial units
  def self.current_weather(location)
    # query sample: 'https://api.openweathermap.org/data/2.5/weather?q=new+york&appid=3207703ee5d0d14e6b6a53d10071018f&units=imperial'
    response = HTTParty.get("https://api.openweathermap.org/data/2.5/weather?q=#{location}&appid=3207703ee5d0d14e6b6a53d10071018f&units=imperial")
    @current_weather = response.parsed_response
    puts @current_weather
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
