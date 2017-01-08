EffectiveTrash.setup do |config|
  # Configure Database Table
  config.trash_table_name = :trash

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

  # Admin Screens Layout Settings
  # config.layout = 'application'   # All EffectiveTrash controllers will use this layout

  config.layout = {
    trash: 'application',
    admin_trash: 'admin',
  }

  # Enable the /trash, /admin/trash and /trash/:id/restore routes. Doesn't affect acts_as_trashable itself.
  config.routes_enabled = true
end
