require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ExampleWebsite
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.load_defaults '6.0'
    Rails.autoloaders.log!

    # Precompile additional assets.
    # application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
    config.assets.version = '1.0'
    config.assets.precompile += %w( admin.js admin.css )

    config.time_zone = 'Mountain Time (US & Canada)'

    # JSON options
    config.action_dispatch.cookies_serializer = :json

    # Enable parameter wrapping for JSON. You can disable this by setting :format to an empty array.
    ActiveSupport.on_load(:action_controller) do
      wrap_parameters format: [:json]
    end

    # Parameters with these names will not be logged to console
    config.filter_parameters += [:password]

    # Session options
    config.session_store :cookie_store, key: '_example_session'

    config.active_job.queue_adapter = :async

    config.action_view.form_with_generates_ids = true
  end
end
