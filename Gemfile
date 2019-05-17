source 'https://rubygems.org'
ruby '2.5.0'

gem 'rails', '6.0.0.rc1'
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
gem 'sassc-rails'
gem 'turbolinks'

gem 'effective_addresses'
gem 'effective_bootstrap'
gem 'effective_ckeditor'
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
  gem 'dotenv-rails', '= 2.7.2'
  gem 'listen'
  gem 'pry-byebug'
  gem 'puma'
  gem 'sqlite3'
end

group :test do
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'webdrivers'
  gem 'effective_test_bot'
  # gem 'rmagick'
end

group :production, :staging do
  gem 'exception_notification'
  gem 'passenger'
  gem 'rails_12factor'
  gem 'rack-timeout'
  gem 'uglifier'
end

group :develop, :staging, :test do
  gem 'sucker_punch'
end

group :production do
  gem 'sidekiq'
end
