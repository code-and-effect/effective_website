EffectivePosts.setup do |config|
  config.posts_table_name = :posts

  # Every post must belong to one or more category.
  # Don't use the category :posts
  config.categories = [:news, :events]

  # Create top level routes for each category
  # Should each of the above categories have a top level route created for it
  # For example:
  #   Visiting /news will display all posts created with the 'news' category
  #   Visiting /events will display all posts created with the 'events' category
  #
  # Regardless of this setting, posts will always be available via /posts?category=events
  config.use_category_routes = true

  # Create routes for a blog. 
  # Includes category routes, but they're not top level.
  # /blog is posts#index
  # /blog/category/announcements is posts#index?category=announcements
  # /blog/1-post-title is posts#show
  config.use_blog_routes = true

  # Number of posts displayed per page (Kaminari)
  config.per_page = 10

  # Post Meta behaviour
  # Should the author be displayed in the post meta?
  # The author is the user that created the Effective::Post object
  config.post_meta_author = true

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
  config.authorization_method = Proc.new do |controller, action, resource|
    authorize!(action, resource)
    resource.respond_to?(:roles_permit?) ? resource.roles_permit?(current_user) : true
  end

  # Layout Settings
  # Configure the Layout per controller, or all at once
  config.layout = {
    posts: 'application',
    admin: 'admin'
  }

  # Add additional permitted params
  # config.permitted_params += [:additional_field]

  # Display the effective roles 'choose roles' input when an admin creates a new post
  config.use_effective_roles = false

  # Hides the Save and Edit Content links from admin. They can just use the textarea input.
  config.use_fullscreen_editor = true

  # Submissions
  # Allow users to submit posts (optionally for approval) to display on the website
  config.submissions_enabled = false

  # When true, a user might be signed in to submit a post. (calls devise's authenticate_user!)
  config.submissions_require_current_user = false

  # When true, an Admin must first approve any newly submitted posts before they'll be displayed
  config.submissions_require_approval = true

  # The Thank you message when they submit a post
  config.submissions_note = "News & Event submitted! A confirmation email has been sent to the website owner. When approved, your submission will appear on the website."

  # Mailer Settings
  # effective_posts will send the admin an email when a post is submitted
  # For all the emails, the same :subject_prefix will be prefixed.  Leave as nil / empty string if you don't want any prefix
  #
  # The subject_for_post_submitted_to_admin can be one of:
  # - nil / empty string to use the built in defaults
  # - A string with the full subject line for this email
  # - A Proc to create the subject line based on the email
  # In all three of these cases, the subject_prefix will still be used.

  # The Procs are the same for admin & buyer receipt, the seller Proc is different
  # subject_for_post_submitted_to_admin: Proc.new { |post| "Post needs approval"}

  config.mailer = {
    subject_prefix: '[example]',
    subject_for_post_submitted_to_admin: '',

    layout: 'effective_posts_mailer_layout',

    default_from: 'info@example.com',
    admin_email: 'admin@example.com',

    deliver_method: nil,   # :deliver (rails < 4.2), :deliver_now (rails >= 4.2) or :deliver_later
    delayed_job_deliver: false
  }

end
