source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.6'
# Use sqlite3 as the database for Active Record
gem 'sqlite3'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# react-rb gems
# gem 'reactrb', '0.8.8'
# gem 'opal', "~> 0.10.0"
# gem 'opal-rails', '0.9.0' # (gives scope error)
# gem 'opal-rails', '0.8.1'
# gem 'therubyracer', platforms: :ruby
# gem 'reactive-record'
# gem 'synchromesh', git: "https://github.com/reactrb/synchromesh.git", branch: "authorization-policies"
gem 'opal_hot_reloader', git: 'https://github.com/fkchang/opal-hot-reloader.git'
# foreman to start rails and hot-loader rocesses

gem 'foreman'



gem 'reactrb'
gem 'react-rails', '>= 1.3.0'
# gem 'opal-rails', '0.8.1' # RR works but we need > 0.8.1 for opal-rspec-rails
gem 'opal-rails', '0.9.0' # now we have the bug Uncaught undefined method `scope' for class (in monkey patched module ActiveRecord)
gem 'therubyracer', platforms: :ruby
gem 'reactive-record', '>= 0.8.0'
gem 'synchromesh', git: "https://github.com/reactrb/synchromesh.git", branch: 'authorization-policies'

group :development, :test do
  gem 'opal-rspec-rails', github: 'opal/opal-rspec-rails'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
  gem 'byebug'
  # gem 'opal-rspec-rails', git: "https://github.com/opal/opal-rspec-rails.git"
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end
