source 'https://rubygems.org'
ruby '2.5.0'

gem 'rails', github: 'rails/rails', branch: '5-2-stable'
gem 'bootsnap', require: false
gem 'pg', '< 1.0'
gem 'turbolinks'

gem 'bootstrap', '~> 4.0.0'
gem 'coffee-rails'
gem 'jquery-rails'
gem 'sass-rails'

gem 'aws-sdk-s3', require: false
gem 'cancancan'
gem 'cocoon'
gem 'devise'
gem 'devise_invitable'
gem 'foreman'
gem 'hamlit-rails'
gem 'puma'
gem 'sucker_punch'

gem 'effective_addresses'
gem 'effective_bootstrap', github: 'code-and-effect/effective_bootstrap', branch: 'master'
gem 'effective_datatables', github: 'code-and-effect/effective_datatables', branch: 'master'
gem 'effective_developer'
gem 'effective_logging'
gem 'effective_orders', github: 'code-and-effect/effective_orders', branch: 'three-dot-zero'
gem 'effective_pages'
gem 'effective_resources', github: 'code-and-effect/effective_resources', branch: 'master'
gem 'effective_roles'
gem 'effective_style_guide'
gem 'effective_trash'

group :development, :test do
  gem 'dotenv-rails'
  gem 'pry-byebug'
end

group :test do
  gem 'effective_test_bot'
end

group :production do
  gem 'exception_notification'
  gem 'rack-timeout'
  gem 'rails_12factor'
end
