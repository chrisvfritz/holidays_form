# These two lines set up our environment to ensure that only the gem versions we've
# specified in our Gemfile will be used. You can find our more at:
# http://bundler.io/bundler_setup.html
require 'rubygems'
require 'bundler/setup'

require 'sinatra/base'
# An alternative templating language that doesn't make us type as much as ERB does
require 'slim'
# Some helpers to make forms work more simply
require 'sinatra/form_helpers'

require_relative 'lib/holiday_app/config'
require_relative 'lib/date_parser'
require_relative 'lib/holidays_fetcher'

module HolidayApp
  class Main < HolidayApp::Config
    set :root, File.dirname(__FILE__)

    # Establishes SUPPORTED_COUNTRIES as a constant (that's what the all caps mean). A constant
    # just means we define it once, then never change it. We put this here instead of inside of
    # our `get '/' do ... end` block so that it's available all throughout our app. Defining
    # constants at a more "global" level is typical.
    SUPPORTED_COUNTRIES = [
      { code: 'BE', name: 'Belgium'       },
      { code: 'BR', name: 'Brazil'        },
      { code: 'GB', name: 'Great Britain' },
      { code: 'US', name: 'United States' }
    ]
    COUNTRY_OPTIONS = SUPPORTED_COUNTRIES.map { |country| [ country[:code], country[:name] ] }

    get '/' do
      # Sets up some defaults for each form field for the first time the page is loaded, before
      # a user has entered anything. We use `||=` to set a value *only* if that parameter currently
      # has no value.
      params['holidays'] ||= {}
      @country = params['holidays']['country'] ||= 'US'
      @date    = params['holidays']['date']      = HolidayApp::DateParser.new params['holidays']['date']

      # Just in case the user manages to sneak in some bad data, like an empty year for those browsers
      # that don't yet support HTML5 form validations (http://caniuse.com/#feat=form-validation), we
      # rescue from the BadRequest exception that the holidapi gem throws and just make @holidays
      # an empty array.
      @holidays = HolidayApp::HolidaysFetcher.new(@country, @date.date_params).results

      # Sets up how we want to display the current country, year, and month. Each one is assigned
      # to an instance variable (one that starts with `@`), so that they will be available in views
      # and helpers.
      @selected_country = SUPPORTED_COUNTRIES.find { |country| country[:code] == @country }[:name]

      slim :'holidays/index'
    end

    # Some helpers to make forms work more simply
    helpers Sinatra::FormHelpers

    # Helper methods allow you to pull complicated and/or repeated logic out of your views. Helper
    # methods are available from any of your view files.
    helpers do

      # Displays a nicely formatted summary of the current search
      def current_search
        @current_search ||= "#{@date} in #{@selected_country}"
      end

      # Formats dates for the search results
      def format_date(date)
        HolidayApp::DateParser.new date
      end

      # Generates the path to generate a flamegraph to help us get a finer-tuned view of performance
      def flamegraph_path
        @flamegraph_path ||= begin
          param_symbol = request.fullpath.index(/\/\?\w+/) ? '&' : '?'
          request.fullpath + "#{param_symbol}pp=flamegraph"
        end
      end

    end

  end
end
