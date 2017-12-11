# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

puts '== Creating users ======================'

user_fields = proc do
  {
    first_name: ['Adam', 'Ben', 'Charles', 'Daniel', 'Eric', 'Farren', 'Greg'].sample,
    last_name: ['Jones', 'Wayne', 'Smith', 'Franklin', 'Dickens', 'the Great'].sample,
    password: 'be_effective',
    password_confirmation: 'be_effective'
  }
end

User.new(user_fields.call.merge(email: 'admin@agilestyle.com', roles: :admin)).save!
User.new(user_fields.call.merge(email: 'admin@codeandeffect.com', roles: :admin)).save!
User.new(user_fields.call.merge(email: 'member@codeandeffect.com', roles: :member)).save!
User.new(user_fields.call.merge(email: 'guest@codeandeffect.com', roles: nil)).save!

# lib/tasks/generate
Rake::Task['generate:effective_pages'].invoke
#Rake::Task['generate:effective_menus'].invoke

Effective::Post.new(
  title: 'First Post',
  category: EffectivePosts.categories.first.presence || 'posts',
  published_at: Time.zone.now,
  draft: false,
  body: '<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer vitae dictum arcu, et tincidunt metus.</p>'
).save!
