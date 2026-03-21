# frozen_string_literal: true

module Legion
  module Extensions
    module Openweathermap
      module Runners
        module Weather
          def current_weather(city: nil, lat: nil, lon: nil, **)
            params = {}
            if city
              params[:q] = city
            elsif lat && lon
              params[:lat] = lat
              params[:lon] = lon
            end
            resp = connection(**).get('/weather', params)
            { weather: resp.body }
          end

          def current_weather_by_id(city_id:, **)
            resp = connection(**).get('/weather', { id: city_id })
            { weather: resp.body }
          end
        end
      end
    end
  end
end
