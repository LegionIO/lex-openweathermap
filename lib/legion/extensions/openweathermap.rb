# frozen_string_literal: true

require 'legion/extensions/openweathermap/version'
require 'legion/extensions/openweathermap/helpers/client'
require 'legion/extensions/openweathermap/runners/weather'
require 'legion/extensions/openweathermap/runners/forecast'
require 'legion/extensions/openweathermap/client'

module Legion
  module Extensions
    module Openweathermap
      extend Legion::Extensions::Core if Legion::Extensions.const_defined? :Core
    end
  end
end
