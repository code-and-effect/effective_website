require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module EffectiveWebsite
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Precompile additional assets.
    # application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
    config.assets.version = '1.0'
    config.assets.precompile += %w( admin.js admin.css )

    # JSON options
    config.action_dispatch.cookies_serializer = :json

    # Enable parameter wrapping for JSON. You can disable this by setting :format to an empty array.
    ActiveSupport.on_load(:action_controller) do
      wrap_parameters format: [:json]
    end

    # Parameters with these names will not be logged to console
    config.filter_parameters += [:password]

    # Session options
    config.session_store :cookie_store, key: '_effective_website_session'

    # sucker_punch runs active jobs asynchronously in the web server process
    config.active_job.queue_adapter = :sucker_punch
  end
end
