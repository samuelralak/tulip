source 'https://rubygems.org'

# ruby '2.2.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.7'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.21'

# user interface
gem 'bootstrap-sass', '~> 3.3.6'
gem 'sass-rails', '~> 5.0'
gem 'compass-rails', '~> 2.0.4'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem "haml-rails", '~> 0.9.0'
gem "font-awesome-rails", '~> 4.5.0.0'
gem 'chosen-rails', '~> 1.4.3'
gem 'bootstrap-chosen-rails', '~> 0.0.4'

# javascript
gem 'jquery-rails', '~> 4.1.0'
gem 'turbolinks', '~> 2.5.3'
gem 'jquery-turbolinks', '~> 2.1.0'
gem 'jbuilder', '~> 2.0'
gem 'toastr-rails', '~> 1.0.3'
gem 'momentjs-rails', '~> 2.9',  :github => 'derekprior/momentjs-rails'
gem 'datetimepicker-rails', github: 'zpaulovics/datetimepicker-rails', branch: 'master', submodules: true
gem 'jquery-datatables-rails', '~> 3.3.0'
gem 'nprogress-rails', '~> 0.1.6.7'
gem 'jquery-ui-rails', '~> 5.0.5'

# use sweet alert
gem 'sweet-alert', '~> 0.0.9'

# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Env variables management
gem "figaro"

group :development do
    gem 'capistrano', '~> 3.4.0', require: false
    gem 'capistrano-rvm', '~> 0.1.2', require: false
    gem 'capistrano-rails', '~> 1.1.6', require: false
    gem 'capistrano-bundler', '~> 1.1', require: false
    gem 'capistrano3-puma', '~> 1.2.1', require: false
end

gem 'capistrano-passenger', '~> 0.2.0'

# Use puma as the app server
gem 'puma'

# Forms
gem 'simple_form', '~> 3.2.1'

# Authentication & Authorization
gem 'devise', '~> 3.5.3'
gem 'cancancan', '~> 1.13.1'
gem "rolify", '~> 5.0.0'

# Calender
gem "simple_calendar", '~> 2.0.3'

# Console
gem 'hirb', '~> 0.7.3'

# Caching
gem 'actionpack-action_caching', '~> 1.1.1'

# Generate PDF
gem 'wicked_pdf', '~> 1.0.3'
gem 'wkhtmltopdf-binary'

gem 'therubyracer', '~> 0.12.3'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

group :production do
  gem 'rails_12factor'
end
