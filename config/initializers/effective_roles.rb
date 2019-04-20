EffectiveRoles.setup do |config|
  # So this is a bit weird because of the flat array
  # The :superadmin, :admin, :client are for USERS
  # the owner, member, collaborator are for MATES
  # Sorry.

  config.roles = [:superadmin, :admin, :reserved, :client, :owner, :member, :collaborator] # Only add to the end of this array.  Never prepend roles.

  # config.role_descriptions
  # ========================
  # This setting configures the text that is displayed by form helpers (see README.md)
  #
  # Use this Hash syntax if you want different labels depending on the resource being editted
  #
  # config.role_descriptions = {
  #   'User' => {
  #     :superadmin => 'full access to everything. Can manage users and all website content.',
  #     :admin => 'full access to website content.  Cannot manage users.',
  #     :member => 'cannot access admin area.  Can see all content in members-only sections of the website.''
  #   },
  #   'Effective::Page' => {
  #     :superadmin => 'allow superadmins to see this page',
  #     :admin => 'allow admins to see this page',
  #     :member => 'allow members to see this page'
  #   }
  # }
  #
  # Or just keep it simple, and use this Hash syntax of permissions for every resource
  #
  config.role_descriptions = {
    # User roles
    :superadmin => 'full access to everything.',
    :admin => 'can log in to the /admin section of the website.',
    :reserved => '',
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
  #
  # Use this Hash syntax if you want different permissions depending on the resource being editted
  #
  # config.assignable_roles = {
  #   'User' => {
  #     :superadmin => [:superadmin, :admin, :member],  # Superadmins may assign Users any role
  #     :admin => [:admin, :member],                    # Admins may only assign a User the :admin or :member role
  #     :member => []                                   # Members may not assign any roles
  #   },
  #   'Page' => {
  #     :superadmin => [:superadmin, :admin, :member],  # Superadmins may create Pages for any role
  #     :admin => [:admin, :member],                    # Admins may create Pages for admin and members
  #     :member => [:member]                            # Members may create Pages for members
  #   }
  #
  # Or just keep it simple, and use this Hash syntax of permissions for every resource
  #
  # config.assignable_roles = {
  #   :superadmin => [:superadmin, :admin, :member], # Superadmins may assign any resource any role
  #   :admin => [:admin, :member],                   # Admins may only assign the :admin or :member role
  #   :member => []                                  # Members may not assign any roles
  # }
  config.assignable_roles = {
    # User roles
    superadmin: [:superadmin, :admin, :client],
    admin: [:admin, :client],
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
