source 'https://rubygems.org'

# this seems sorta useful, yep
gem 'rails', '4.2.3'
gem 'rails_12factor' # for heroku

# calendar helpers
gem 'google-api-client'
gem 'simple_calendar'
gem 'momentjs-rails' # specifically for forms
gem 'bootstrap3-datetimepicker-rails'

# authentication & secrets
gem 'dotenv-rails', :groups => [:development, :test]
gem 'bcrypt', '~> 3.1.7'
gem 'omniauth-oauth2', '1.3.1' # 1.4.0 causes redirect uri issues for google_oauth2
gem 'omniauth'
gem 'omniauth-github'
gem 'omniauth-google-oauth2'

# database
gem 'pg'

# assets
gem 'sass-rails', '~> 5.0'
gem 'bootstrap-sass'
gem 'font-awesome-sass'
# gem 'neat' # NOPE sorry

# javascript magics
gem 'uglifier', '>= 1.3.0'
gem 'jquery-rails'

# documentation helpers
gem 'sdoc', '~> 0.4.0', group: :doc # bundle exec rake doc:rails generates the API under doc/api.

group :test do
  # testing
  gem 'rspec-rails'
  gem 'simplecov', require: false # helper for test coverage
  gem 'codeclimate-test-reporter', require: nil
  gem 'factory_girl_rails'
  gem 'shoulda-matchers'
end

group :development, :test do
  # for debugging
  gem 'pry-rails' # pry <3
  gem 'better_errors' # improve error console in browser
  gem 'binding_of_caller' # improve error console in browser

  # for keeping server running and stuff
  gem 'spring' # Read more: https://github.com/rails/spring
end
