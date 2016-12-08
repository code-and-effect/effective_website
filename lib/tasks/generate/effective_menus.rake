class EffectiveMenusGenerator
  def self.generate
    generator = new()
    generator.create_main_menu
  end

  def create_main_menu
    Effective::Menu.where(title: 'main menu').first.try(:destroy)

    Effective::Menu.new(title: 'main menu').build do
      item 'News', '/news'
      item 'Blog', '/blog'

      item Effective::Page.find_by_title('About')
      item Effective::Page.find_by_title('Contact')

      dropdown 'Members Only', roles_mask: 1 do  # Must have the member role
        item Effective::Page.find_by_title('Member Information')
      end

      dropdown 'Account', signed_in: true do
        item 'Admin', '/admin', roles_mask: 2  # Must have the admin role
        item 'Settings', :user_settings_path
        divider
        item 'Sign Out', :destroy_user_session_path
      end

      item 'Sign In', :new_user_session_path, signed_out: true
    end.save!

    Effective::Menu.new(title: 'footer menu').build do
      item 'News', '/news'
      item 'Blog', '/blog'
      item Effective::Page.find_by_title('About')
      item Effective::Page.find_by_title('Contact')
    end.save!

  end
end


# bundle exec generate:effective_menus
namespace :generate do
  task :effective_menus => :environment do
    puts "== Generating effective menus =="
    EffectiveMenusGenerator.generate
  end
end
