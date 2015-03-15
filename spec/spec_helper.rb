require 'rubygems'

if ENV['CODECLIMATE_REPO_TOKEN']
  require 'codeclimate-test-reporter'
  CodeClimate::TestReporter.start
else
  require 'simplecov'
  SimpleCov.start
end

require 'capybara/rspec'
require 'webmock'
require 'vcr'

require_relative '../app'

HolidayApp::Main.environment = :test
Bundler.require :default, HolidayApp::Main.environment

VCR.configure do |config|
  config.cassette_library_dir = 'spec/fixtures/cassettes'
  config.hook_into :webmock
  config.ignore_localhost = true
  config.ignore_hosts 'codeclimate.com'
end

Capybara.app = HolidayApp::Main
