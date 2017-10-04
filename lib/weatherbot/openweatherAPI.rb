class Weatherbot::API
  attr_accessor :google_maps_link, :location, :response_code, :coordinates, :country, :location_name, :temp_avg, :temp_celsius, :condition, :cloudiness, :humidity, :wind_speed, :wind_direction, :report_time, :google_maps, :sunrise, :sunset, :tonight, :tmrw_day, :tmrw_night, :second_day, :second_night, :third_day, :third_night, :tonight_dt, :tmrw_day_dt, :tmrw_night_dt, :google_maps_link

  def initialize
    @location = location
    @coordinates = coordinates
    @google_maps_link = google_maps_link
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

    current_conditions.coordinates = parsed_weather["coord"].values.reverse.join(", ")
    current_conditions.location_name = parsed_weather["name"]
    current_conditions.report_time = Time.at(parsed_weather["dt"])

    # Open query in browser to Google Maps
    current_conditions.google_maps = "https://www.google.com/maps/place/#{current_conditions.coordinates.gsub(" ", "")}"
    @google_maps_link = current_conditions.google_maps

    current_conditions.temp_avg = parsed_weather["main"]["temp"]
    current_conditions.condition = parsed_weather["weather"].first["description"]
    current_conditions.cloudiness = parsed_weather["clouds"]["all"]

    # current_conditions.pressure = parsed_weather["main"]["pressure"]

    current_conditions.humidity = parsed_weather["main"]["humidity"]
    current_conditions.wind_speed = parsed_weather["wind"]["speed"]

    current_conditions.sunrise = Time.at(parsed_weather["sys"]["sunrise"])
    current_conditions.sunset = Time.at(parsed_weather["sys"]["sunset"])

    # Check for odd locations with no country key
    if parsed_weather.fetch("sys").has_key?("country")
      current_conditions.country = parsed_weather["sys"]["country"]
    else
      current_conditions.country = nil
    end

    wind_deg = parsed_weather["wind"]["deg"]
    temp_f = parsed_weather["main"]["temp"]

    # Helper function to convert degrees to wind direction
    def self.degToCompass(wind_deg)
      val = ((wind_deg.to_f / 22.5) + 0.5).floor
      direction_arr = ["N", "NNE", "NE", "ENE", "E", "ESE", "SE", "SSE", "S", "SSW", "SW", "WSW", "W", "WNW", "NW", "NNW"]
      return direction_arr[(val % 16)]
    end

    # Helper function to convert to Celsius
    def self.toCelsius(temp_f)
      ((temp_f - 32) * (5.0 / 9.0)).round(2)
    end

    current_conditions.wind_direction = self.degToCompass(wind_deg)
    current_conditions.temp_celsius = self.toCelsius(temp_f)

      puts "\nReport Time:      #{current_conditions.report_time}"
      puts "Location:         #{current_conditions.location_name}, #{current_conditions.country}"
      puts "Coordinates:      #{current_conditions.coordinates}"
      puts "Google Maps:      #{current_conditions.google_maps}"
      puts "\nTemperature:      #{current_conditions.temp_avg}ºF / #{current_conditions.temp_celsius}ºC"
      puts "Condition:        #{current_conditions.condition.capitalize}"
      puts "Cloudiness:       #{current_conditions.cloudiness}%"

      puts "\nHumidity:         #{current_conditions.humidity}%"
      puts "Wind Speed:       #{current_conditions.wind_speed} mph"
      puts "Wind Direction:   #{current_conditions.wind_direction}"

      puts "\nSunrise:          #{current_conditions.sunrise}"
      puts "Sunset:           #{current_conditions.sunset}"
    end
  end


  # Takes user input to enter into URL query for 3 day forecast in imperial units
  def self.forecast(location)
    # query sample: https://api.openweathermap.org/data/2.5/forecast?q=new+york&appid=3207703ee5d0d14e6b6a53d10071018f&units=imperial
    response = HTTParty.get("https://api.openweathermap.org/data/2.5/forecast?q=#{location}&appid=3207703ee5d0d14e6b6a53d10071018f&units=imperial")
    parsed_forecast = response.parsed_response
    forecast = self.new

    forecast.tonight = parsed_forecast["list"][0]
    forecast.tonight_dt = parsed_forecast["list"][0]["dt_txt"]
    forecast.tmrw_day = parsed_forecast["list"][5]
    forecast.tmrw_day_dt = parsed_forecast["list"][5]["dt_txt"]
    forecast.tmrw_night = parsed_forecast["list"][8]
    forecast.tmrw_night_dt = parsed_forecast["list"][8]["dt_txt"]
    forecast.second_day = parsed_forecast["list"][13]
    forecast.second_night = parsed_forecast["list"][16]
    forecast.third_day = parsed_forecast["list"][21]
    forecast.third_night = parsed_forecast["list"][24]

    puts forecast.tonight_dt
    puts forecast.tmrw_day_dt
    puts forecast.tmrw_night_dt

  end

  # Method to open link in Google Maps depending on OS
  def self.open_link
    link = @google_maps_link
    if RbConfig::CONFIG['host_os'] =~ /mswin|mingw|cygwin/
      system "start #{link}"
    elsif RbConfig::CONFIG['host_os'] =~ /darwin/
      system "open #{link}"
    elsif RbConfig::CONFIG['host_os'] =~ /linux|bsd/
      system "xdg-open #{link}"
    end
  end
  # def self.popular_cities
  #   # List 10 popular cities
  #   # format: City name, Country Code
  #
  #   puts "-------------------------------"
  #   puts ""
  #   puts "1. London, United Kingdom"
  #   puts "2. New York City, United States"
  #   puts "3. Shanghai, China"
  #   puts "4. Tokyo, Japan"
  #   puts "5. Berlin, Germany"
  #   puts "6. Lagos, Nigeria"
  #   puts "7. Istanbul, Turkey"
  #   puts "8. Mumbai, India"
  #   puts "9. Moscow, Russia"
  #   puts "10. São Paulo, Brazil"
  #   puts ""
  #   puts "-------------------------------"
  #
  #
  # end


end
