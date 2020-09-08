ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'

require 'rails/test_help'
require 'minitest/spec'
require 'minitest/reporters'
require 'minitest/fail_fast' if EffectiveTestBot.fail_fast?
require 'support/application_test_helper'

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  if respond_to?(:parallelize)
    parallelize(workers: 4)

    parallelize_setup do |worker|
      load "#{Rails.root}/db/seeds.rb"
      load "#{Rails.root}/test/fixtures/seeds.rb"
    end
  end

  include ApplicationTestHelper
  include EffectiveTestBot::DSL

  fixtures :all               # Loads all fixtures in test/fixtures/*.yml
  extend Minitest::Spec::DSL  # For the let syntax
end

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

Rails.backtrace_cleaner.remove_silencers!
Rails.backtrace_cleaner.add_silencer { |line| line =~ /minitest/ }
#Rails.backtrace_cleaner.add_silencer { |line| line =~ /effective_test_bot/ }

# Enable these two if you can't parallelize
# setup = ['db:schema:load', 'db:fixtures:load', 'db:seed', 'test:load_fixture_seeds'].join(' ')
# system("rails #{setup} RAILS_ENV=test")

# rails test
# rails test:system
# rails test:bot:environment
# rails test:bot
# rails test:bot:fails
# rails test:bot:fail

# rails test:system TOUR=true
# rails test:bot TEST=posts#index
