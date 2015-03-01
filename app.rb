# These two lines set up our environment to ensure that only the gem versions we've
# specified in our Gemfile will be used. You can find our more at:
# http://bundler.io/bundler_setup.html
require 'rubygems'
require 'bundler/setup'

require 'sinatra/base'
# An alternative templating language that doesn't make us type as much as ERB does.
require 'slim'
# Some helpers to make forms work more simply.
require 'sinatra/form_helpers'
require 'holidapi'
# Date is part of the core Ruby library (i.e. is not part of some other gem), but is
# not loaded by default. If we want to use it, as we do to use Date:'MONTH'NAMES, then
# we need to require it. Find out more about the date library and what else it allows
# us to do in the Ruby docs: http://ruby-doc.org/stdlib-2.2.0/libdoc/date/rdoc/Date.html
require 'date'
# Helps us format dates and times nicely by giving an example.
require 'stamp'

class HolidayApp < Sinatra::Base
  helpers Sinatra::FormHelpers

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

  get '/' do
    # Gets the current time and puts it in an instance variable (that's what the "@" indicates),
    # so that we can also use it in our ERB files. Check out all the stuff you can do with
    # the `Time` class in the Ruby docs: http://ruby-doc.org//core-2.2.0/Time.html
    @current_time = Time.now

    # Sets up some defaults for each form field for the first time the page is loaded, before
    # a user has entered anything. For country and month, we use `||=` to set a value
    # only if that parameter has no value. For the year, we do something a bit different,
    # checking not only if the year has no value (i.e. is "nil"), but also if the year
    # is an empty string, which is a possibility in browsers where the `required` attribute
    # doesn't prevent empty submissions of form elements.
    params['holidays']            ||= {}
    params['holidays']['country'] ||= 'US'
    params['holidays']['year']      = @current_time.year.to_s if params['holidays']['year'].nil? || params['holidays']['year'].empty?
    params['holidays']['month']   ||= @current_time.month.to_s

    # Just in case the user manages to sneak in some bad data, like an empty year for those browsers
    # that don't yet support HTML5 form validations (http://caniuse.com/#feat=form-validation), we
    # rescue from the BadRequest exception that the holidapi gem throws and just make @holidays
    # an empty array.
    @holidays = begin
      # The `flatten` method takes annoying arrays within array within arrays and "flattens" them
      # all down to one level. In this case, it ensures that we get a single array of hashes, each
      # hash containing a holiday. Find out more about `flatten` in the Ruby docs:
      # http://ruby-doc.org//core-2.2.0/Array.html#method-i-flatten
      HolidApi.get( country: params['holidays']['country'], year: params['holidays']['year'], month: params['holidays']['month'] ).flatten
    rescue HolidApi::BadRequest
      []
    end

    # Sets up how we want to display the current country, year, and month. Each one is assigned
    # to an instance variable (one that starts with `@`), so that they will be available in views
    # and helpers.
    @selected_country = SUPPORTED_COUNTRIES.find { |country| country[:code] == params['holidays']['country'] }[:name]
    @selected_year    = params['holidays']['year']
    @selected_month   = Date::MONTHNAMES[ params['holidays']['month'].to_i ]

    slim :'holidays/index'
  end

  # Helper methods allow you to pull complicated and/or repeated logic out of your views. Helper
  # methods are available from any of your view files.
  helpers do

    def current_search
      "#{@selected_month} #{@selected_year} in #{@selected_country}"
    end

    def country_options
      SUPPORTED_COUNTRIES.map { |country| [ country[:code], country[:name] ] }
    end

    def month_options
      (1..12).map { |month| [ month.to_s, Date::MONTHNAMES[month] ] }
    end

    def format_date(date)
      Date.parse(date).stamp('March 1st, 2015')
    end

  end

end
