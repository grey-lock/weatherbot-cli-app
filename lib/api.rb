
class Weatherbot::API < Helper
  attr_accessor :location, :response_code, :coordinates, :country, :location_name, :temp_avg, :temp_celsius, :condition, :cloudiness, :humidity, :wind_speed, :wind_direction, :report_time, :google_maps, :google_maps_link, :sunrise, :sunset, :hr24_dt, :hr48_dt, :hr72_dt, :temp24, :temp48, :temp72, :condition24, :condition48, :condition72, :cloudiness24, :cloudiness48, :cloudiness72, :humidity24, :humidity48, :humidity72, :wind_speed24, :wind_speed48, :wind_speed72, :wind_direction24, :wind_direction48, :wind_direction72

  @@locations = []

  def initialize
    @location = location
    @@locations << self
  end

  def self.locations
    @@locations
  end

  # Takes user input to enter into URL query & gets current weather conditions in imperial units
  def self.current_weather(location)
    # query sample: 'https://api.openweathermap.org/data/2.5/weather?q=new+york&appid=3207703ee5d0d14e6b6a53d10071018f&units=imperial'
    response = HTTParty.get("https://api.openweathermap.org/data/2.5/weather?q=#{location}&appid=3207703ee5d0d14e6b6a53d10071018f&units=imperial")
    parsed = response.parsed_response
    @current = self.new
    @current.response_code = parsed["cod"]

    # Check for invalid entry
    if @current.response_code === "404"
      puts "\n\nInvalid location, please enter a valid location.\n\n"
      return
    else
      # Assign attributes to current weather object
    @current.coordinates = parsed["coord"].values.reverse.join(", ")
    @current.location_name = parsed["name"]
    @current.report_time = Time.at(parsed["dt"])
    @current.temp_avg = parsed["main"]["temp"]
    @current.condition = parsed["weather"].first["description"]
    @current.cloudiness = parsed["clouds"]["all"]
    # @current.pressure = parsed["main"]["pressure"]
    @current.humidity = parsed["main"]["humidity"]
    @current.wind_speed = parsed["wind"]["speed"]
    @current.sunrise = Time.at(parsed["sys"]["sunrise"])
    @current.sunset = Time.at(parsed["sys"]["sunset"])
    @current.wind_direction = degToCompass(parsed["wind"]["deg"])
    @current.temp_celsius = toCelsius(parsed["main"]["temp"])

    # Open query in browser to Google Maps
    @current.google_maps = "https://www.google.com/maps/place/#{@current.coordinates.gsub(" ", "")}"
    @google_maps_link = @current.google_maps

    # Check for odd locations with no country key
    if parsed.fetch("sys").has_key?("country")
      @current.country = parsed["sys"]["country"]
    else
      @current.country = nil
    end


    end

    @current
  end


  # Takes user input to enter into URL query for 3 day forecast in imperial units
  def self.forecast(location)
    # query sample: https://api.openweathermap.org/data/2.5/forecast?q=new+york&appid=3207703ee5d0d14e6b6a53d10071018f&units=imperial
    response = HTTParty.get("https://api.openweathermap.org/data/2.5/forecast?q=#{location}&appid=3207703ee5d0d14e6b6a53d10071018f&units=imperial")
    parsed = response.parsed_response
    forecast = self.new

    forecast.location_name = @current.location_name
    # 24/48/72hr date
    forecast.hr24_dt = parsed["list"][8]["dt_txt"]
    forecast.hr48_dt = parsed["list"][16]["dt_txt"]
    forecast.hr72_dt = parsed["list"][24]["dt_txt"]
    # 24/48/72hr temp
    forecast.temp24 = parsed["list"][8]["main"]["temp"]
    forecast.temp48 = parsed["list"][16]["main"]["temp"]
    forecast.temp72 = parsed["list"][24]["main"]["temp"]
    # 24/48/72hr condition
    forecast.condition24 = parsed["list"][8]["weather"][0]["description"]
    forecast.condition48 = parsed["list"][16]["weather"][0]["description"]
    forecast.condition72 = parsed["list"][24]["weather"][0]["description"]
    # 24/48/72hr cloudiness
    forecast.cloudiness24 = parsed["list"][8]["clouds"]["all"]
    forecast.cloudiness48 = parsed["list"][16]["clouds"]["all"]
    forecast.cloudiness72 = parsed["list"][24]["clouds"]["all"]
    # 24/48/72hr humidity
    forecast.humidity24 = parsed["list"][8]["main"]["humidity"]
    forecast.humidity48 = parsed["list"][16]["main"]["humidity"]
    forecast.humidity72 = parsed["list"][24]["main"]["humidity"]
    # 24/48/72hr wind speed & direction
    forecast.wind_speed24 = parsed["list"][8]["wind"]["speed"]
    forecast.wind_speed48 = parsed["list"][16]["wind"]["speed"]
    forecast.wind_speed72 = parsed["list"][24]["wind"]["speed"]
    forecast.wind_direction24 = degToCompass(parsed["list"][8]["wind"]["deg"])
    forecast.wind_direction48 = degToCompass(parsed["list"][16]["wind"]["deg"])
    forecast.wind_direction72 = degToCompass(parsed["list"][24]["wind"]["deg"])

    # Open query in browser to Google Maps
    forecast.google_maps = "https://www.google.com/maps/place/#{@current.coordinates.gsub(" ", "")}"
    @google_maps_link = @current.google_maps

    # Output 3 day forecast
    puts "\n-------------------------------\n"
    puts "\n\nIn 24 Hours:"
    puts "\nReport Time:      #{forecast.hr24_dt}"
    puts "Location:         #{forecast.location_name},  #{@current.country}"
    puts "Google Maps:      #{forecast.google_maps}"
    puts "\nTemperature:      #{forecast.temp24}ºF / #{toCelsius(forecast.temp24)}ºC"
    puts "Condition:        #{forecast.condition24.capitalize}"
    puts "Cloudiness:       #{forecast.cloudiness24}%"
    puts "\nHumidity:         #{forecast.humidity24}%"
    puts "Wind Speed:       #{forecast.wind_speed24} mph"
    puts "Wind Direction:   #{forecast.wind_direction24}"

    puts "\n-------------------------------\n"
    puts "\n\nIn 48 Hours:"
    puts "\nReport Time:      #{forecast.hr48_dt}"
    puts "Location:         #{forecast.location_name},  #{@current.country}"
    puts "Google Maps:      #{forecast.google_maps}"
    puts "\nTemperature:      #{forecast.temp48}ºF / #{toCelsius(forecast.temp48)}ºC"
    puts "Condition:        #{forecast.condition48.capitalize}"
    puts "Cloudiness:       #{forecast.cloudiness48}%"
    puts "\nHumidity:         #{forecast.humidity48}%"
    puts "Wind Speed:       #{forecast.wind_speed48} mph"
    puts "Wind Direction:   #{forecast.wind_direction48}"

    puts "\n-------------------------------\n"
    puts "\n\nIn 72 Hours:"
    puts "\nReport Time:      #{forecast.hr72_dt}"
    puts "Location:         #{forecast.location_name}, #{@current.country}"
    puts "Google Maps:      #{forecast.google_maps}"
    puts "\nTemperature:      #{forecast.temp72}ºF / #{toCelsius(forecast.temp72)}ºC"
    puts "Condition:        #{forecast.condition72.capitalize}"
    puts "Cloudiness:       #{forecast.cloudiness72}%"
    puts "\nHumidity:         #{forecast.humidity72}%"
    puts "Wind Speed:       #{forecast.wind_speed72} mph"
    puts "Wind Direction:   #{forecast.wind_direction72}"

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
