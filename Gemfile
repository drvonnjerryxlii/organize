source 'https://rubygems.org'

gem 'rails', '4.2.3' # Bundle edge Rails instead: gem 'rails', github: 'rails/rails'

# API helpers
gem "google_calendar"


# gem "fullcalendar-wrapper-rails" # gem wrapper for fullcalendar.io


# authentication & secrets
gem 'dotenv-rails', :groups => [:development, :test]
gem 'bcrypt', '~> 3.1.7' # Use ActiveModel has_secure_password
# may need twitter, github, facebook for oauth


# assets
gem 'sass-rails', '~> 5.0' # Use SCSS for stylesheets
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# javascript magics
gem 'uglifier', '>= 1.3.0' # Use Uglifier as compressor for JavaScript assets
gem 'jquery-rails' # Use jquery as the JavaScript library
gem 'turbolinks' # Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'jbuilder', '~> 2.0' # Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem "momentjs-rails"


# documentation helpers
gem 'sdoc', '~> 0.4.0', group: :doc # bundle exec rake doc:rails generates the API under doc/api.


group :development, :test do
  # for debugging
  gem "pry-rails" # pry <3
  gem 'better_errors' # improve error console in browser
  gem 'binding_of_caller' # improve error console in browser
  gem 'byebug' # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'web-console', '~> 2.0' # Access an IRB console on exception pages or by using <%= console %> in views


  # testing
  gem 'rspec-rails'
  gem 'simplecov', require: false # helper for test coverage


  # database for early development
  gem 'sqlite3' # Use sqlite3 as the database for Active Record

  # some sort of magic
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

group :production do
  # database for production?
  gem 'pg'
end
