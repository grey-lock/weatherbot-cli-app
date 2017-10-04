
class Weatherbot::API < Helper
  attr_accessor :google_maps_link, :location, :response_code, :coordinates, :country, :location_name, :temp_avg, :temp_celsius, :condition, :cloudiness, :humidity, :wind_speed, :wind_direction, :report_time, :google_maps, :sunrise, :sunset, :hr24, :hr24_dt, :hr48, :hr48_dt, :hr72, :hr72_dt, :google_maps_link

  def initialize
    @location = location
    @coordinates = coordinates
    @google_maps_link = google_maps_link
  end


  # Takes user input to enter into URL query & gets current weather conditions in imperial units
  def self.current_weather(location)
    # query sample: 'https://api.openweathermap.org/data/2.5/weather?q=new+york&appid=3207703ee5d0d14e6b6a53d10071018f&units=imperial'
    response = HTTParty.get("https://api.openweathermap.org/data/2.5/weather?q=#{location}&appid=3207703ee5d0d14e6b6a53d10071018f&units=imperial")
    parsed = response.parsed_response
    current = self.new
    current.response_code = parsed["cod"]

    # Check for invalid entry
    if current.response_code === "404"
      puts "\n\nInvalid location, please enter a valid location.\n\n"
      return
    else

    current.coordinates = parsed["coord"].values.reverse.join(", ")
    current.location_name = parsed["name"]
    current.report_time = Time.at(parsed["dt"])
    current.temp_avg = parsed["main"]["temp"]
    current.condition = parsed["weather"].first["description"]
    current.cloudiness = parsed["clouds"]["all"]
    # current.pressure = parsed["main"]["pressure"]
    current.humidity = parsed["main"]["humidity"]
    current.wind_speed = parsed["wind"]["speed"]
    current.sunrise = Time.at(parsed["sys"]["sunrise"])
    current.sunset = Time.at(parsed["sys"]["sunset"])

    wind_deg = parsed["wind"]["deg"]
    temp_f = parsed["main"]["temp"]
    current.wind_direction = degToCompass(wind_deg)
    current.temp_celsius = toCelsius(temp_f)

    # Open query in browser to Google Maps
    current.google_maps = "https://www.google.com/maps/place/#{current.coordinates.gsub(" ", "")}"
    @google_maps_link = current.google_maps

    # Check for odd locations with no country key
    if parsed.fetch("sys").has_key?("country")
      current.country = parsed["sys"]["country"]
    else
      current.country = nil
    end

      puts "\nReport Time:      #{current.report_time}"
      puts "Location:         #{current.location_name}, #{current.country}"
      puts "Coordinates:      #{current.coordinates}"
      puts "Google Maps:      #{current.google_maps}"
      puts "\nTemperature:      #{current.temp_avg}ºF / #{current.temp_celsius}ºC"
      puts "Condition:        #{current.condition.capitalize}"
      puts "Cloudiness:       #{current.cloudiness}%"
      puts "\nHumidity:         #{current.humidity}%"
      puts "Wind Speed:       #{current.wind_speed} mph"
      puts "Wind Direction:   #{current.wind_direction}"
      puts "\nSunrise:          #{current.sunrise}"
      puts "Sunset:           #{current.sunset}"
    end
  end


  # Takes user input to enter into URL query for 3 day forecast in imperial units
  def self.forecast(location)
    # query sample: https://api.openweathermap.org/data/2.5/forecast?q=new+york&appid=3207703ee5d0d14e6b6a53d10071018f&units=imperial
    response = HTTParty.get("https://api.openweathermap.org/data/2.5/forecast?q=#{location}&appid=3207703ee5d0d14e6b6a53d10071018f&units=imperial")
    parsed = response.parsed_response
    forecast = self.new

    forecast.location_name = parsed["name"]
    forecast.temp24avg = parsed["list"][6]["main"]["temp"]
    forecast.temp48avg = parsed["list"][14]["main"]["temp"]
    forecast.temp72avg = parsed["list"][22]["main"]["temp"]
    forecast.condition24 = parsed["list"][6]["weather"][0]["description"]
    forecast.condition48 = parsed["list"][14]["weather"][0]["description"]
    forecast.condition72 = parsed["list"][22]["weather"][0]["description"]
    forecast.cloudiness24 = parsed["list"][6]["clouds"]["all"]
    forecast.cloudiness48 = parsed["list"][14]["clouds"]["all"]
    forecast.cloudiness72 = parsed["list"][22]["clouds"]["all"]
    forecast.humidity = parsed["main"]["humidity"]
    forecast.wind_speed = parsed["wind"]["speed"]
    forecast.sunrise = Time.at(parsed["sys"]["sunrise"])
    forecast.sunset = Time.at(parsed["sys"]["sunset"])

    wind_deg = parsed["wind"]["deg"]
    temp_f = parsed["main"]["temp"]
    forecast.wind_direction = degToCompass(wind_deg)
    forecast.temp_celsius = toCelsius(temp_f)

    # Open query in browser to Google Maps
    forecast.google_maps = "https://www.google.com/maps/place/#{current.coordinates.gsub(" ", "")}"
    @google_maps_link = current.google_maps

    # Check for odd locations with no country key
    if parsed.fetch("sys").has_key?("country")
      current.country = parsed["sys"]["country"]
    else
      current.country = nil
    end

    # Forecast hash every 24 hours up to 72hrs
    forecast.hr24 = parsed["list"][6]
    forecast.hr24_dt = parsed["list"][6]["dt_txt"]

    forecast.hr48 = parsed["list"][14]
    forecast.hr48_dt = parsed["list"][14]["dt_txt"]
    forecast.hr72 = parsed["list"][22]
    forecast.hr72_dt = parsed["list"][22]["dt_txt"]

    # Output 3 day forecast
    puts "\n\nTomorrow"
    puts "\nReport Time:      #{forecast.hr24_dt}"
    puts "Location:         #{forecast.location_name}, #{forecast.country}"
    puts "Coordinates:      #{forecast.coordinates}"
    puts "Google Maps:      #{forecast.google_maps}"
    puts "\nTemperature:      #{forecast.temp_avg}ºF / #{forecast.temp_celsius}ºC"
    puts "Condition:        #{forecast.condition.capitalize}"
    puts "Cloudiness:       #{forecast.cloudiness}%"
    puts "\nHumidity:         #{forecast.humidity}%"
    puts "Wind Speed:       #{forecast.wind_speed} mph"
    puts "Wind Direction:   #{forecast.wind_direction}"
    puts "\nSunrise:          #{forecast.sunrise}"
    puts "Sunset:           #{forecast.sunset}"

    puts "\n-------------------------------\n"
    puts "\n\nIn 48 Hours:"
    puts "\nReport Time:      #{forecast.hr48_dt}"
    puts "Location:         #{forecast.location_name}, #{forecast.country}"
    puts "Coordinates:      #{forecast.coordinates}"
    puts "Google Maps:      #{forecast.google_maps}"
    puts "\nTemperature:      #{forecast.temp_avg}ºF / #{forecast.temp_celsius}ºC"
    puts "Condition:        #{forecast.condition.capitalize}"
    puts "Cloudiness:       #{forecast.cloudiness}%"
    puts "\nHumidity:         #{forecast.humidity}%"
    puts "Wind Speed:       #{forecast.wind_speed} mph"
    puts "Wind Direction:   #{forecast.wind_direction}"
    puts "\nSunrise:          #{forecast.sunrise}"
    puts "Sunset:           #{forecast.sunset}"

    puts "\n-------------------------------\n"
    puts "\n\nIn 72 Hours:"
    puts "\nReport Time:      #{forecast.hr72_dt}"
    puts "Location:         #{forecast.location_name}, #{forecast.country}"
    puts "Coordinates:      #{forecast.coordinates}"
    puts "Google Maps:      #{forecast.google_maps}"
    puts "\nTemperature:      #{forecast.temp_avg}ºF / #{forecast.temp_celsius}ºC"
    puts "Condition:        #{forecast.condition.capitalize}"
    puts "Cloudiness:       #{forecast.cloudiness}%"
    puts "\nHumidity:         #{forecast.humidity}%"
    puts "Wind Speed:       #{forecast.wind_speed} mph"
    puts "Wind Direction:   #{forecast.wind_direction}"
    puts "\nSunrise:          #{forecast.sunrise}"
    puts "Sunset:           #{forecast.sunset}"

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


end
