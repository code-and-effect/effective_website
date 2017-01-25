# EffectivePosts Rails Engine

EffectivePosts.setup do |config|
  config.posts_table_name = :posts

  # Every post must belong to one or more category.
  # Don't use the category :posts
  config.categories = [:blog, :news]

  # Create top level routes for each category
  # Should each of the above categories have a top level route created for it
  # - Visiting /blog will display all posts created with the :blog category
  # - Visiting /news will display all posts created with the :news category
  #
  # Regardless of this setting, posts will always be available via /posts?category=blog
  config.use_category_routes = true

  # Number of posts displayed per page (Kaminari)
  config.per_page = 10

  # Post Meta behaviour
  # Should the author be displayed in the post meta?
  # The author is the user that created the Effective::Post object
  config.post_meta_author = true

  # Use CanCan: authorize!(action, resource)
  # Use effective_roles: resource.roles_permit?(current_user)
  config.authorization_method = Proc.new { |controller, action, resource| authorize!(action, resource) }

  # Layout Settings
  # Configure the Layout per controller, or all at once
  config.layout = {
    :pages => 'application',
    :admin => 'admin'
  }

  # SimpleForm Options
  # This Hash of options will be passed into any simple_form_for() calls
  config.simple_form_options = {}

  # config.simple_form_options = {
  #   :html => {:class => 'form-horizontal'},
  #   :wrapper => :horizontal_form,
  #   :wrapper_mappings => {
  #     :boolean => :horizontal_boolean,
  #     :check_boxes => :horizontal_radio_and_checkboxes,
  #     :radio_buttons => :horizontal_radio_and_checkboxes
  #   }
  # }

end
