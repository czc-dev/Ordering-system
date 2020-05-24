source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.5'

gem 'rails',        '~> 6.0'
gem 'pg',           '~> 1.1'
gem 'puma',         '~> 3.12'
gem 'slim-rails',   '~> 3.2'
gem 'bootsnap',     '~> 1.4', require: false
gem 'httparty',     '~> 0.17'
gem 'paper_trail',  '~> 10.3'
gem 'discard',      '~> 1.1'
gem 'kaminari',     '~> 1.1'
gem 'webpacker',    '~> 4.2'
gem 'sorcery',      '~> 0.15'

group :development, :test do
  gem 'pry-byebug'
  gem 'faker'
  gem 'gimei'
  gem 'rspec-rails'
  gem 'rails-controller-testing'
  gem 'foreman'
  gem 'dotenv-rails', require: 'dotenv/rails-now'
  gem 'factory_bot_rails'
end

group :development do
  gem 'web-console'
  gem 'listen'
  gem 'spring'
  gem 'spring-watcher-listen'
  gem 'rails-erd'
  gem 'bullet'
  gem 'rubocop', require: false
end

group :test do
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'webdrivers'
  gem 'shoulda-matchers'
  gem 'database_cleaner'
end
