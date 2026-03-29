# lex-openweathermap: OpenWeatherMap Integration for LegionIO

**Repository Level 3 Documentation**
- **Parent**: `/Users/miverso2/rubymine/legion/extensions-other/CLAUDE.md`
- **Grandparent**: `/Users/miverso2/rubymine/legion/CLAUDE.md`

## Purpose

Legion Extension that connects LegionIO to OpenWeatherMap via the REST API v2.5. Provides runners for current weather conditions and forecasts.

**GitHub**: https://github.com/LegionIO/lex-openweathermap
**License**: MIT
**Version**: 0.1.2

## Architecture

```
Legion::Extensions::Openweathermap
├── Runners/
│   ├── Weather    # current_weather (by city, lat/lon, city ID), current_weather_by_id
│   └── Forecast   # five_day_forecast, hourly_forecast
├── Helpers/
│   └── Client     # Faraday connection to api.openweathermap.org (API key via query param)
└── Client         # Standalone client class (includes all runners)
```

## Key Files

| Path | Purpose |
|------|---------|
| `lib/legion/extensions/openweathermap.rb` | Entry point, extension registration |
| `lib/legion/extensions/openweathermap/runners/weather.rb` | Current weather runners |
| `lib/legion/extensions/openweathermap/runners/forecast.rb` | Forecast runners |
| `lib/legion/extensions/openweathermap/helpers/client.rb` | Faraday connection builder (appid query param) |
| `lib/legion/extensions/openweathermap/client.rb` | Standalone Client class |

## Authentication

OpenWeatherMap uses an API key passed as the `appid` query parameter on every request. Pass `api_key:` at client construction.

## Configuration

Supported `units` values: `metric` (default), `imperial`, `standard`.

## Dependencies

| Gem | Purpose |
|-----|---------|
| `faraday` (~> 2.0) | HTTP client for OpenWeatherMap REST API |

## Development

14 specs total.

```bash
bundle install
bundle exec rspec
bundle exec rubocop
```

---

**Maintained By**: Matthew Iverson (@Esity)
