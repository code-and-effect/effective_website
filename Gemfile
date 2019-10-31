source 'https://rubygems.org'
ruby '2.6.3'

gem 'rails'
gem 'bootsnap', require: false
gem 'pg'

gem 'aws-sdk-s3', require: false
gem 'bootstrap'
gem 'cancancan'
gem 'cocoon'
gem 'coffee-rails'
gem 'devise'
gem 'devise_invitable'
gem 'foreman', '= 0.63.0'
gem 'haml'
gem 'jquery-rails'
gem 'sass-rails', '~> 5'
gem 'turbolinks'

gem 'effective_addresses'
gem 'effective_bootstrap'
gem 'effective_ckeditor'
gem 'effective_regions'
gem 'effective_datatables'
gem 'effective_developer'
gem 'effective_logging'
gem 'effective_orders'
gem 'effective_pages'
gem 'effective_posts'
gem 'effective_resources'
gem 'effective_roles'
gem 'effective_style_guide'

group :development, :test do
  gem 'dotenv-rails'
  gem 'listen'
  gem 'pry-byebug'  # binding.pry
  gem 'puma'
  gem 'sqlite3'
end

group :test do
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'webdrivers'
  gem 'effective_test_bot'
  # gem 'rmagick' # required for animated gifs from effective_test_bot
end

group :production, :staging do
  gem 'exception_notification'
  gem 'passenger'
  gem 'rails_12factor'
  gem 'rack-timeout'
  gem 'uglifier'
end

group :production do
  gem 'sidekiq'
end
