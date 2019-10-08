source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'

gem 'rails',        '~> 5.2'
gem 'pg',           '~> 1.1'
gem 'puma',         '~> 3.12'
gem 'slim-rails',   '~> 3.2'
gem 'bcrypt',       '~> 3.1'
gem 'bootsnap',     '~> 1.4', require: false
gem 'dotenv-rails', '~> 2.7', require: 'dotenv/rails-now'
gem 'httparty',     '~> 0.17'
gem 'paper_trail',  '~> 10.3'
gem 'discard',      '~> 1.1'
gem 'kaminari',     '~> 1.1'

group :development, :test do
  gem 'pry-byebug'
  gem 'faker'
  gem 'gimei'
  gem 'rspec-rails'
  gem 'rails-controller-testing'
end

group :development do
  gem 'web-console'
  gem 'listen'
  gem 'spring'
  gem 'spring-watcher-listen'
  gem 'rails-erd'
  gem 'bullet'
  gem 'rack-proxy'
end

group :test do
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'webdrivers'
  gem 'factory_bot_rails'
  gem 'shoulda-matchers'
  gem 'database_cleaner'
end
