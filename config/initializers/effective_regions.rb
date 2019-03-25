EffectiveRegions.setup do |config|
  config.regions_table_name = :regions

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



  # Before Region Save Method
  #
  # This method is called when a User clicks the 'Save' button in the full screen editor.
  # It will be called once for each region immediately before the regions are saved to the database.
  #
  # This is not an ActiveRecord before_save callback and there is no way to cancel the save.
  #
  # This method is run on the controller.view_context, so you have access to all your regular
  # view helpers as well as the request object.
  #
  # The second argument, 'parent', will be the Effective::Region's parent regionable object, or the symbol :global
  #
  # If you are gsub'ing the region.content String value or altering the region.snippets Hash values,
  # those changes will not be immediately visible on the front-end.
  #
  # If you need the user to immediately see these changes, have your Proc or function return the symbol :refresh
  #
  # Returning the symbol :refresh will instruct javascript to perform a full page refresh after the Save is complete.
  #
  # Don't change the region.title, as this will orphan the region
  #
  # Use via Proc:
  #
  # config.before_save_method = Proc.new do |region, parent|
  #   region.content = region.content.gsub('force', 'horse') if region.title == 'body'
  #   :refresh
  # end
  #
  # Use via custom method:
  # config.before_save_method = :my_region_before_save_method
  #
  # And then in your application_controller.rb:
  #
  # def my_region_before_save_method(region, parent)
  #   if region.title == 'body' && request.fullpath == posts_path
  #     region.content = region.content.gsub('force', 'horse')
  #     :refresh
  #   end
  # end
  #
  # Or disable the callback completely:
  # config.before_save_method = false

  config.before_save_method = false
end
