# Holidays Form App

[![Build Status](https://travis-ci.org/chrisvfritz/holidays_form.svg)](https://travis-ci.org/chrisvfritz/holidays_form) [![Code Climate](https://codeclimate.com/github/chrisvfritz/holidays_form/badges/gpa.svg)](https://codeclimate.com/github/chrisvfritz/holidays_form) [![Test Coverage](https://codeclimate.com/github/chrisvfritz/holidays_form/badges/coverage.svg)](https://codeclimate.com/github/chrisvfritz/holidays_form) [![Dependency Status](https://gemnasium.com/chrisvfritz/holidays_form.svg)](https://gemnasium.com/chrisvfritz/holidays_form) [![Heroku App](https://img.shields.io/badge/heroku-tc359--holidays--form-brightgreen.svg?style=flat)](http://tc359-holidays-form.herokuapp.com/)

This is a simple Sinatra app to demonstrate how the holidays form project in TC359 might be completed by a professional Ruby web developer. The `master` branch contains the most advanced version of the app from the `overachiever` branch. For those that are looking for smaller steps to improve your app, check out the `lazy_basic` and `lazy_mega` branches.

## Run locally

``` bash
git clone https://github.com/chrisvfritz/holidays_form.git
cd holidays_form
```

``` bash
# If you don't have Ruby 2.2.0 installed
rbenv install 2.2.0 # for rbenv
# OR
rvm install ruby-2.2.0 # for rvm
```

``` bash
bundle install
bundle exec rackup
```
