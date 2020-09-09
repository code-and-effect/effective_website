if Rails.env.test?
  EffectiveTestBot.setup do |config|

    # Exclude the following tests or assertions from being run.
    # config.except = [
    #   'widgets',
    #   'posts#create_invalid',
    #   'posts#index page_title',
    #   'posts#update_invalid' => ['page_title', 'current_path'],
    #   'no_unpermitted_params'
    # ]

    # Run only the following tests.  Doesn't work with individual assertions
    # config.only = [
    #   'posts', 'events#index'
    # ]

    config.except = ['test_exception_path']

    # Silence skipped routes
    config.silence_skipped_routes = false

    # Set the current user on a per test basis. You must have at least 1 user seeded.
    # test is a String as per the except, only and TEST= test names
    # proc = { |test| user = User.first; puts "#{test} #{user}"; user }
    config.user = proc { |test|
      test.start_with?('admin') ? User.first : Client.last.mates.with_role(:owner).first.user
    }

    # Exits immediately if there is a test failure
    config.fail_fast = false

    # Display x number of lines of a backtrace
    config.backtrace_lines = 12

    # Fill form fields with these values
    # Based on the input name
    # :email => 'j.smith@website.com', 'user.last_name' => 'Smith'
    config.form_fills = {}

    # Should capybara generate a series of *.png screenshots as it goes through the test?
    # Disabling screenshots will also disable animated_gifs and touring
    config.screenshots = true

    # Save on failure to /tmp/ directory
    config.autosave_animated_gif_on_failure = true

    # Take the tour!
    # Generate an animated gif for each test
    # Saved to an appropriate /test/tour/* directory
    # Also enabled the crud_test #tour type tests
    #
    # You can override this default by setting an ENV or calling
    # `rake test:bot TOUR=true` or `rake test:bot TEST=posts TOUR=verbose`
    #
    # Valid values are true / false / :verbose
    config.tour_mode = false

    # Rmagick gem is required for animated gifs
    #
    # Include the following in your Gemfile:
    # gem 'rmagick'
    config.image_processing_class_name = 'Magick'

    # FUTURE SUPPORT: ImageProcessing gem is required for animated gifs
    # I'm not sure how to make an animated gif with this gem!
    # gem 'image_processing'
    # ImageProcessing::MiniMagick
    # ImageProcessing::Vips
    # config.image_processing_class_name = 'ImageProcessing::MiniMagick'

    # How long to delay in between animated gif frames
    # The last frame is applied animated_gif_frame_delay * 3
    # 100 equals 1 second. (a bit on the slow side, but suitable for a demo)
    config.animated_gif_delay = 100

    # Shorter than maximum height animated gif frames have their
    # bottom area filled by this color
    # For best appearance, have this match your site's background color
    config.animated_gif_background_color = 'white'
  end
end
