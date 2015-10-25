source 'https://rubygems.org'

# this seems sorta useful, yep
gem 'rails', '4.2.3'

# calendar helpers
gem 'google-api-client'
gem 'simple_calendar'

# authentication & secrets
gem 'dotenv-rails', :groups => [:development, :test]
gem 'bcrypt', '~> 3.1.7' # Use ActiveModel has_secure_password
gem 'omniauth-oauth2', '1.3.1' # 1.4.0 causes redirect uri issues for google_oauth2
gem 'omniauth'
gem 'omniauth-github'
gem 'omniauth-google-oauth2'

# database
gem 'pg'

# assets
gem 'sass-rails', '~> 5.0' # Use SCSS for stylesheets
gem 'bootstrap-sass'
gem 'font-awesome-sass'
# gem 'neat' # NOPE sorry

# javascript magics
gem 'uglifier', '>= 1.3.0' # Use Uglifier as compressor for JavaScript assets
gem 'jquery-rails' # Use jquery as the JavaScript library

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
