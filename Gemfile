source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.3'

gem 'rails', '~> 5.2.1'
gem 'pg'
gem 'puma'
gem 'sassc-rails'
gem 'slim-rails'
gem 'jquery-rails'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'bcrypt', '~> 3.1.7'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'dotenv-rails', require: 'dotenv/rails-now'
gem 'httparty'

group :development, :test do
  gem 'pry-byebug'
  gem 'faker'
  gem 'rspec-rails'
  gem 'rails-controller-testing'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'rails-erd'
  gem 'bullet'
  gem 'capistrano'
  gem 'capistrano-rails'
  gem 'capistrano-rbenv'
  gem 'capistrano-bundler'
  gem 'capistrano-passenger'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  gem 'chromedriver-helper'
  gem 'factory_bot_rails'
  gem 'shoulda-matchers'
  gem 'database_cleaner'
end
