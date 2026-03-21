# Changelog

## [0.1.0] - 2026-03-21

### Added
- Initial release
- `Helpers::Client` — Faraday connection builder targeting OpenWeatherMap API v2.5 with `appid` query param auth and configurable `units`
- `Runners::Weather` — current_weather (by city or lat/lon), current_weather_by_id
- `Runners::Forecast` — five_day_forecast, hourly_forecast
- Standalone `Client` class for use outside the Legion framework
