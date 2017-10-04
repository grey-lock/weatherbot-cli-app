class Helper

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


end
