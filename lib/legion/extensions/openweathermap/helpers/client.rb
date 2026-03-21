# frozen_string_literal: true

require 'faraday'

module Legion
  module Extensions
    module Openweathermap
      module Helpers
        module Client
          BASE_URL = 'https://api.openweathermap.org/data/2.5'

          def connection(api_key: nil, units: 'metric', **_opts)
            Faraday.new(url: BASE_URL) do |conn|
              conn.request :json
              conn.response :json, content_type: /\bjson$/
              conn.params['appid'] = api_key if api_key
              conn.params['units'] = units
              conn.adapter Faraday.default_adapter
            end
          end
        end
      end
    end
  end
end
