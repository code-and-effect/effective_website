EffectiveRoles.setup do |config|
  # So this is a bit weird because of the flat array
  # The :admin, :staff, :client and :reserved are for USERS
  # the owner, member, collaborator are for MATES
  # Sorry.

  config.roles = [:admin, :staff, :client, :reserved, :owner, :member, :collaborator] # Only add to the end of this array.  Never prepend roles.

  # config.role_descriptions
  # ========================
  # This setting configures the text that is displayed by form helpers (see README.md)

  config.role_descriptions = {
    # User roles
    :admin => 'can log in to the /admin section of the website. full access to everything.',
    :staff => 'can log in to the /admin section of the website.',
    :client => 'can log in to the /client section of the website.',

    # Mate roles
    :owner => 'can manage client settings and orders',
    :member => 'can create, update and destroy client resources',
    :collaborator => 'can view client resources'
  }

  # config.assignable_roles
  # Which roles can be assigned by whom
  # =======================
  # When current_user is passed into a form helper function (see README.md)
  # this setting determines which roles that current_user may assign
  
  config.assignable_roles = {
    # User roles
    admin: [:admin, :staff, :client],
    staff: [:staff, :client],
    client: [],
    reserved: [],

    # Mate roles
    owner: [:member, :collaborator],
    member: [:member, :collaborator],
    collaborator: []
  }

  # config.disabled_roles
  # Which roles should be displayed as disabled
  # =========================
  # Sometimes you don't want a role to be assignable (see README.md)
  # So that you can overload it yourself and assingn the role programatically
  #
  # Use this Hash syntax if you want different permissions depending on the resource being editted
  #
  # config.disabled_roles = {
  #   'User' => [:member]               # When editing a User object, will be unable to assign the member role
  #   'Page' => [:superadmin, :admin]   # When editing a Page object, will be unable to assign superadmin, admin role
  # }
  #
  # Or just keep it simple, and use this Array syntax of permissions for every resource
  #
  # config.disabled_roles = [:member]
  #
  # or
  #
  # config.disabled_roles = {
  #   'User' => [:member]
  # }


  # config.authorization_method_for_summary_table
  # This has absolutely no affect on the any logic involving roles
  # It's purely for the effective_roles_summary_table() helper method
  #
  # It should match the authorization check used by your application
  #
  # Use CanCan: can?(action, resource)
  config.authorization_method = Proc.new { |controller, action, resource| authorize!(action, resource) }

  # Layout Settings
  # Configure the Layout per controller, or all at once
  config.layout = 'admin'
end
