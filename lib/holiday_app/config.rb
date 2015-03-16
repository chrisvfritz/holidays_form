require 'sinatra/base'

module HolidayApp
  class Config < Sinatra::Base

    # Gives us performance metrics on every page load in development
    configure :development, :test do
      require 'rack-mini-profiler'
      require 'flamegraph'
      require 'stackprof'
      use Rack::MiniProfiler
    end

    # Server monitoring by New Relic
    configure :production do
      require 'newrelic_rpm'
    end

    set :root, File.dirname(__FILE__) + '/../..'

  end
end