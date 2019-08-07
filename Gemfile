source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'

gem 'rails',        '5.2.3'
gem 'pg',           '1.1.4'
gem 'puma',         '3.12.1'
gem 'slim-rails',   '3.2.0'
gem 'bcrypt',       '3.1.7'
gem 'bootsnap',     '1.4.4', require: false
gem 'dotenv-rails', '2.7.2', require: 'dotenv/rails-now'
gem 'httparty',     '0.17.0'
gem 'paper_trail',  '10.3.1'

group :development, :test do
  gem 'pry-byebug'
  gem 'faker'
  gem 'gimei'
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
  gem 'rack-proxy'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  gem 'webdrivers'
  gem 'factory_bot_rails'
  gem 'shoulda-matchers'
  gem 'database_cleaner'
end
