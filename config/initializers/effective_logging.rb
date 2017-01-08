EffectiveLogging.setup do |config|
  # Configure Database Tables
  config.logs_table_name = :logs

  # Authorization Method
  #
  # This method is called by all controller actions with the appropriate action and resource
  # If the method returns false, an Effective::AccessDenied Error will be raised (see README.md for complete info)
  #
  # Use via Proc (and with CanCan):
  # config.authorization_method = Proc.new { |controller, action, resource| can?(action, resource) }
  #
  # Use via custom method:
  # config.authorization_method = :my_authorization_method
  #
  # And then in your application_controller.rb:
  #
  # def my_authorization_method(action, resource)
  #   current_user.is?(:admin)
  # end
  #
  # Or disable the check completely:
  # config.authorization_method = false
  config.authorization_method = Proc.new { |controller, action, resource| authorize!(action, resource) } # CanCanCan

  # Register Effective::Logs with ActiveAdmin if ActiveAdmin is present
  config.use_active_admin = true

  # Admin Screens Layout Settings
  # config.layout = 'application'   # All EffectiveLogging controllers will use this layout

  config.layout = {
    logs: 'application',
    admin_logs: 'admin',
  }

  # All statuses defined here, as well as 'info', 'success', and 'error' (hardcoded) will be created as
  # EffectiveLogger.info('my message') macros
  config.additional_statuses = []

  #########################################
  #### Automatic Logging Functionality ####
  #########################################

  # Log all emails sent
  config.emails_enabled = true

  # Log all successful user login attempts
  config.user_logins_enabled = true
  config.user_logouts_enabled = false
end
