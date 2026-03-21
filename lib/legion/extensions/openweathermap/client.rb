# frozen_string_literal: true

require_relative 'helpers/client'
require_relative 'runners/weather'
require_relative 'runners/forecast'

module Legion
  module Extensions
    module Openweathermap
      class Client
        include Helpers::Client
        include Runners::Weather
        include Runners::Forecast

        attr_reader :opts

        def initialize(api_key:, units: 'metric', **extra)
          @opts = { api_key: api_key, units: units, **extra }
        end

        def settings
          { options: @opts }
        end

        def connection(**override)
          super(**@opts, **override)
        end
      end
    end
  end
end
