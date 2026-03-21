# lex-openweathermap

LegionIO extension for OpenWeatherMap integration via the OpenWeatherMap REST API v2.5.

## Installation

Add to your Gemfile:

```ruby
gem 'lex-openweathermap'
```

## Standalone Usage

```ruby
require 'legion/extensions/openweathermap'

client = Legion::Extensions::Openweathermap::Client.new(api_key: 'your-api-key')

# Current weather by city
client.current_weather(city: 'London')

# Current weather by coordinates
client.current_weather(lat: 44.98, lon: -93.27)

# Current weather by city ID
client.current_weather_by_id(city_id: 2_643_743)

# 5-day forecast
client.five_day_forecast(city: 'Berlin')

# Hourly forecast (cnt controls number of timestamps, default 8)
client.hourly_forecast(city: 'New York', cnt: 4)
```

## Authentication

OpenWeatherMap uses an API key passed as the `appid` query parameter. Obtain a free key at: https://openweathermap.org/api

## Units

Supported `units` values: `metric` (default), `imperial`, `standard`.

## License

MIT
