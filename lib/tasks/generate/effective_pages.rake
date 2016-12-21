class EffectivePagesGenerator
  def self.generate
    generator = new()
    generator.create_public_pages
    generator.create_member_pages
  end

  def create_public_pages
    Effective::Page.new(
      title: 'About',
      meta_description: 'About the effective website',
      layout: 'application',
      template: 'page'
    ).save!

    Effective::Page.new(
      title: 'Contact',
      meta_description: 'Contact us at the effective website',
      layout: 'application',
      template: 'page'
    ).save!
  end

  def create_member_pages
    page = Effective::Page.new(
      title: 'Member Information',
      meta_description: 'A members-only page',
      layout: 'application',
      template: 'page'
    )

    page.roles = EffectiveRoles.roles  # User with any of these roles can see this page.
    page.save!
  end

end

# bundle exec rake generate:effective_pages
namespace :generate do
  task :effective_pages => :environment do
    puts "== Generating effective pages =="
    EffectivePagesGenerator.generate
  end
end
