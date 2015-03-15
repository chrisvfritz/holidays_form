source 'https://rubygems.org'
ruby '2.2.0'

# ------
# SERVER
# ------

# A DSL for creating simple webapps
gem 'sinatra', '~> 1.4.5'
# A better webserver than the default WEBrick.
gem 'thin', '~> 1.6.3'
# Using `bundle exec shotgun`, we the server will automatically reload when it needs to.
gem 'shotgun', '~> 0.9.1'

# ----------
# TEMPLATING
# ----------

# An alternative templating language that doesn't make us type as much as ERB does.
gem 'slim', '~> 3.0.3'
# Some helpers to make forms work more simply.
gem 'sinatra-formhelpers-ng', '~> 1.9.0'

# ------------
# API WRAPPERS
# ------------

# Pointing to my version on GitHub, since the main version is broken. This will be necessary until this PR is accepted:
# https://github.com/tatemae-consultancy/holidapi/pull/1
gem 'holidapi', github: 'chrisvfritz/holidapi'

# -------------
# DATE HANDLING
# -------------

# Allows detection of date precision when parsing a string into a date
gem 'date_time_precision', '~> 0.8.0'
# Helps us format dates and times nicely by giving an example.
gem 'stamp', '~> 0.6.0'

# -----------------------------
# DEVELOPMENT-ONLY DEPENDENCIES
# -----------------------------

group :development do
  # Locking rack to version 1.5.2 in development, due to a bug that messes up error messages:
  # https://github.com/sinatra/sinatra/issues/951
  gem 'rack', '1.5.2'
  # Allows us to automatically re-run specs on file saves with `bundle exec guard`
  gem 'guard-rspec', '~> 4.5.0', require: false
end

# ----------------------------------
# DEVELOPMENT/TEST-ONLY DEPENDENCIES
# ----------------------------------

group :development, :test do
  # Gives us performance metrics on every page load in development
  gem 'rack-mini-profiler', '~> 0.9.3'
  # Provides a flamegraph to rack-mini-profiler
  gem 'flamegraph', '~> 0.1.0'
  # Allows us to do a better stacktrace on our code
  gem 'stackprof', '~> 0.2.7'
end

# ----------------------
# TEST-ONLY DEPENDENCIES
# ----------------------

group :test do
  # DSL for writing specs
  gem 'rspec', '~> 3.2.0'
  # Used to ordinalize months in date_parser_spec
  gem 'activesupport', '~> 4.2.0'
  # Records HTTP requests and plays them back to avoid constantly hitting the Holiday API
  gem 'vcr', '~> 2.9.3'
  # Stubs external requests so that we can use VCR-generated fixtures instead
  gem 'webmock', '~> 1.20.4'
  # Allows us to check the front-end in our specs
  gem 'capybara', '~> 2.4.4'
  # Generates test coverage metrics locally
  gem 'simplecov', '~> 0.9.2', require: false
  # Sends stats about our code to Code Climate during builds
  gem 'codeclimate-test-reporter', require: nil
end