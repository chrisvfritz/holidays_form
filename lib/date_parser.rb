# Allows us check the precision specified when we're parsing a date string
require 'date_time_precision'
# Allows us to format dates and time much more easily than strftime
require 'stamp'

# The date parsing was getting a little complicated, so I figured it'd be a
# good idea to extract it out into its own class, which also makes it easier
# to test in isolation.

module HolidayApp
  class DateParser

    # Does initial parsing of the date string into an actual Ruby date. If
    # Date.parse doesn't like what it's being given, we check if it converts
    # nicely to an integer and if it does, assume that they're just trying
    # to specify an entire year. If it doesn't, fall back to today's date.
    def initialize(date)
      @date = Date.parse date.to_s
    rescue ArgumentError
      @date = (date_int = date.to_i) == 0 ? Date.today : Date.new(date_int)
    end

    # Returns the date parameters for the Holiday API, deleting any parameters
    # where the value is false.
    def date_params
      {
        year: year,
        month: month,
        day: day
      }.delete_if { |key, value| !value }
    end

    # Formats the date appropriately, depending on specificity,
    # when parsed dates are converted to a string.
    def to_s
      return @date.stamp('January 1st, 2010') if @date.day?
      return @date.stamp('January 2010')      if @date.month?
      @date.stamp('2010')
    end

  private

    # Creates methods for year, month, and day, returning false if the
    # date was inferred by Ruby's date class, rather then specified by
    # the user. Otherwise returns the year, month, or day as an integer.
    %i(year month day).each do |arst|
      define_method(arst) { @date.send("#{arst}?") && @date.send(arst) }
    end

  end
end