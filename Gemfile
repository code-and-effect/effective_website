source 'https://rubygems.org'
ruby '2.7.1'

# Rails Gems
gem 'rails'
gem 'bootsnap'
gem 'pg'
gem 'sass-rails'
gem 'webpacker'

# Community Gems
gem 'cancancan'
gem 'cocoon'
gem 'devise'
gem 'devise_invitable'
gem 'foreman'
gem 'haml'
gem 'turbolinks'

# Omniauth Gems
gem 'omniauth-oauth2'
# gem 'omniauth-microsoft_graph'
# gem 'omniauth-github'
# gem 'omniauth-facebook'
# gem 'omniauth-google-oauth2'

# Optional Gems
# gem 'aws-sdk-s3', require: false

# Effective Gems
gem 'effective_addresses'
gem 'effective_bootstrap'
gem 'effective_ckeditor'
gem 'effective_datatables'
gem 'effective_developer'
gem 'effective_logging'
gem 'effective_orders'
gem 'effective_regions'
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
