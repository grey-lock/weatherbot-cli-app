class Weatherbot::OpenweatherAPI
  attr_accessor :city, :country_code

  def initialize
    @city = city
  end

  def self.query(city)
    # query sample: 'https://api.openweathermap.org/data/2.5/weather?q=New+York&appid=3207703ee5d0d14e6b6a53d10071018f'
    response = HTTParty.get("https://api.openweathermap.org/data/2.5/weather?q=#{city}&appid=3207703ee5d0d14e6b6a53d10071018f")
    puts response
  end


  def self.popular_cities
    # Should open list of 10 popular cities
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



end
