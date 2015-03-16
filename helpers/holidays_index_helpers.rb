require_relative '../lib/date_parser'

module HolidayApp
  module HolidaysIndexHelpers

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