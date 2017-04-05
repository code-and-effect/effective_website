class EffectiveMenusGenerator
  def self.generate
    generator = new()
    generator.create_main_menu
  end

  def create_main_menu
    Effective::Menu.where(title: 'main').first.try(:destroy)
    Effective::Menu.where(title: 'footer').first.try(:destroy)

    Effective::Menu.new(title: 'main').build do
      item 'News', '/news'
      item 'Events', '/events'

      item Effective::Page.find_by_title('About')
      item Effective::Page.find_by_title('Contact')

      dropdown 'Members Only', roles: :member do  # Must have the member role
        item Effective::Page.find_by_title('Member Information')
      end

      item 'Style Guide', '/style_guide'

      dropdown 'Account', signed_in: true do
        item 'Settings', :user_settings_path
        item 'Site Admin', '/admin', roles: :admin # Must have the admin role
        divider
        item 'Sign Out', :destroy_user_session_path
      end

      item 'Sign In', :new_user_session_path, signed_out: true
    end.save!

    Effective::Menu.new(title: 'footer').build do
      item 'News', '/news'
      item 'Events', '/events'
      item Effective::Page.find_by_title('About')
      item Effective::Page.find_by_title('Contact')
    end.save!

  end
end


# bundle exec rake generate:effective_menus
namespace :generate do
  task :effective_menus => :environment do
    puts "== Generating effective menus =="
    EffectiveMenusGenerator.generate
  end
end
