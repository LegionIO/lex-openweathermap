# frozen_string_literal: true

module Legion
  module Extensions
    module Openweathermap
      module Runners
        module Forecast
          def five_day_forecast(city:, **)
            resp = connection(**).get('/forecast', { q: city })
            { forecast: resp.body }
          end

          def hourly_forecast(city:, cnt: 8, **)
            resp = connection(**).get('/forecast', { q: city, cnt: cnt })
            { forecast: resp.body }
          end
        end
      end
    end
  end
end
