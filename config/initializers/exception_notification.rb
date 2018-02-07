if Rails.env.production?
  require 'exception_notification/rails'
  require 'exception_notification/sidekiq' if defined?(Sidekiq)

  ExceptionNotification.configure do |config|
    # Ignore additional exception types.
    # ActiveRecord::RecordNotFound, Mongoid::Errors::DocumentNotFound, AbstractController::ActionNotFound and ActionController::RoutingError are already added.
    # config.ignored_exceptions += %w{ActionView::TemplateError CustomError}

    # Email notifier sends notifications by email.
    config.add_notifier :email, {
      :email_prefix         => '[EW] ',
      :sender_address       => %{"EW" <website@example.com>},
      :exception_recipients => %w{errors@agilestyle.com}
    }

  end
end
