# Weatherbot

A Ruby CLI wrapper using the OpenWeatherMap.org API with interactive features that allow you to search any location's current weather, quick link to the map in Google Maps, and also display the 3 day forecast.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'weatherbot'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install weatherbot

## Usage
Weatherbot is a Ruby gem that utilizes OpenWeatherMap’s API to retrieve current and forecast weather conditions based on a user’s input.

Type 'weatherbot' to start the program.

You will be prompted to enter a location. Anywhere works, the API responds to almost any entry, even if it is misspelled.

Many popular locations will work. In order to get the most accurate results, typing in <location>, <country> will work in almost every query.

The data is outputted to the terminal and shows:

- The Report Time and the timezone your computer is in
- The API response best guess of the location you typed with the country code
- The coordinates of the weather station that returned the data
- A google maps link to the coordinates
- Current temperature & conditions
- Cloudiness
- Humidity
- Wind Speed & Direction
- Sunrise and Sunset

You can type ‘forecast’ to display the results’ 3 days weather forecast in 24 hour intervals.

After typing in a location, you can type ‘map’ to open your OS browser to the Google Maps coordinates of the result.

To quit the program type ‘exit’.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/TheInvalidNonce/weatherbot. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Weatherbot project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/TheInvalidNonce/weatherbot/blob/master/CODE_OF_CONDUCT.md).
