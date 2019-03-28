EffectivePages.setup do |config|
  config.pages_table_name = :pages
  config.menus_table_name = :menus
  config.menu_items_table_name = :menu_items

  # The directory where your page templates live
  # Any files in this directory will be automatically available when
  # creating/editting an Effective::Page from the Admin screens
  # Relative to app/views/
  config.pages_path = '/effective/pages/'

  # Excluded Pages
  # Any page templates from the above directory that should be excluded
  config.excluded_pages = []

  # Excluded Layouts
  # Any app/views/layouts/ layout files that should be excluded
  config.excluded_layouts = [:admin]

  # The site_title will be used to populate the og:site_name tag
  config.site_title = "#{Rails.application.class.name.split('::').first.titleize}"

  # The site_title_suffix will be appended to the effective_pages_header_tags title tag
  config.site_title_suffix = " | #{Rails.application.class.name.split('::').first.titleize}"

  # This site_og_image is the filename for an image placed in /assets/images and will be used to populate the og:image tag
  config.site_og_image = ''

  # When using the effective_pages_header_tags() helper in <head> to set the <meta name='description'>
  # The value will be populated from an Effective::Page's .meta_description field,
  # a present @meta_description controller instance variable or this fallback value.
  # This will be truncated to 150 characters.
  config.fallback_meta_description = ''

  # Turn off missing meta page title and meta description warnings
  config.silence_missing_page_title_warnings = false
  config.silence_missing_meta_description_warnings = false

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
  config.authorization_method = Proc.new { |controller, action, resource| authorize!(action, resource) && resource.roles_permit?(current_user) } # CanCanCan
  # Use effective_roles:  resource.roles_permit?(current_user)

  # Layout Settings
  # Configure the Layout per controller, or all at once

  # The layout for the EffectivePages admin screen
  config.layout = {
    :admin => 'admin'
  }

  # All effective_page menu options
  config.menu = {
    :apply_active_class => true,  # Add an .active class to the appropriate li item based on current page url
    :maxdepth => 2                # 2 by default, strict bootstrap3 doesnt support dropdowns in your dropdowns
  }

end
