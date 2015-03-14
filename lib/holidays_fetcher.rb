# A simple gem that allows us to more easily access the Holiday API from Ruby.
require 'holidapi'

# The holiday fetching was getting a little complicated, so I figured it'd be a
# good idea to extract it out into its own class, which also makes it easier
# to test in isolation.

module HolidayApp
  class HolidaysFetcher

    # Very simple initialize method, which just takes the passed in country and
    # date_params and assigns them to instance variables, so that they are available
    # in all the instance methods.
    def initialize(country, date_params)
      @country     = country
      @date_params = date_params
    end

    # This is a method that exposes the normalized results to the world outside of
    # this class.
    def results
      normalized_results
    end

  private

    # Do a bit of normalizing, since the holidapi gem will return results in
    # different formats, depending on the level of specificity. If the results are
    # a hash, convert it into an array of the hash's values (which will be arrays
    # of holiday hashes, clustered by day). If it's not a hash, it should be an array
    # and I'll just use that. Either way, I get an array at the end and then I flatten
    # that array, ensuring that in the end, I always get the same format: an array
    # of hashes.
    def normalized_results
      ( api_results.is_a?(Hash) ? api_results.values : api_results ).flatten
    end

    # Grabs the raw, ugly results from the holidapi gem. I assign it to an
    # instance variable to memoize this method, ensuring that it's only run
    # once and we just reuse the results we previously grabbed if the API is
    # called again.
    def api_results
      @api_results ||= HolidApi.get( { country: @country }.merge(@date_params) )
    end

  end
end