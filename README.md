# Holidays Form App

[![Build Status](https://travis-ci.org/chrisvfritz/holidays_form.svg)](https://travis-ci.org/chrisvfritz/holidays_form) [![Code Climate](https://codeclimate.com/github/chrisvfritz/holidays_form/badges/gpa.svg)](https://codeclimate.com/github/chrisvfritz/holidays_form) [![Test Coverage](https://codeclimate.com/github/chrisvfritz/holidays_form/badges/coverage.svg)](https://codeclimate.com/github/chrisvfritz/holidays_form) [![Dependency Status](https://gemnasium.com/chrisvfritz/holidays_form.svg)](https://gemnasium.com/chrisvfritz/holidays_form) [![Heroku App](https://img.shields.io/badge/heroku-tc359--holidays--form-brightgreen.svg?style=flat)](http://tc359-holidays-form.herokuapp.com/)

This is a simple Sinatra app to demonstrate how the holidays form project in TC359 might be completed by a professional Ruby web developer. The `master` branch contains the most advanced version of the app. For those looking for smaller steps to improve your app, check out the [`lazy_basic`](https://github.com/chrisvfritz/holidays_form/tree/lazy_basic) and [`lazy_mega`](https://github.com/chrisvfritz/holidays_form/tree/lazy_mega) branches. As you look through the code, read the comments for explanations as to what's happening and why I've done things this way.

## Questions?

If you have questions, [open a new issue](https://github.com/chrisvfritz/holidays_form/issues/new) and I'd be happy to explain any aspect of this project in more detail.

## Run locally

Clone the repo:

``` bash
git clone https://github.com/chrisvfritz/holidays_form.git
cd holidays_form
```

If you don't have Ruby 2.2.0 installed, you can just delete `ruby '2.2.0'` from the Gemfile, but the application has only been tested with this version. If you want to install Ruby 2.2.0, you can:

``` bash
rbenv install 2.2.0 # for rbenv
# OR
rvm install ruby-2.2.0 # for rvm
```

And finally, to run the server:

``` bash
bundle install
bundle exec shotgun
```
