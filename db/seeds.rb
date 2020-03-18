# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

puts '== Creating users ======================'

# The webmaster and/or super priviledged staff member. Can do anything.
admin = User.create!(email: 'admin@codeandeffect.com', first_name: 'Admin', last_name: 'User', roles: :admin, password: 'example')

# Can access /admin and administer the site.
staff = User.create!(email: 'staff@codeandeffect.com', first_name: 'Staff', last_name: 'User', roles: :staff, password: 'example')

puts '== Creating clients ===================='
# Can access /clients and belong to client groups.
3.times do
  client = Client.new(name: Faker::Company.name)

  [:owner, :member, :collaborator].each do |role|
    user = User.create!(
      email: "#{role}@#{client.name.parameterize}.com",
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      roles: :client,
      password: 'be_effective'
    )

    client.mates.build(user: user, roles: role)
  end

  client.save!
end

puts '== Creating pages ======================'

# Some Pages
Effective::Page.new(
  title: 'About',
  meta_description: 'About the example website',
  layout: 'application',
  template: 'page'
).save!

Effective::Page.new(
  title: 'Contact',
  meta_description: 'Contact us at the example website',
  layout: 'application',
  template: 'page'
).save!

Effective::Page.new(
  title: 'Members Only',
  meta_description: 'A example members-only page',
  layout: 'application',
  template: 'page',
  roles: [:client]  # Only clients can see this page.
).save!

puts '== Creating posts ====================='

# Some Posts
post = Effective::Post.new(
  title: 'An example first post',
  excerpt: '<p>This is the most effective first post on the internet.</p>',
  description: 'An effective first post',
  body: 'An example first post.',
  category: EffectivePosts.categories.first.presence || 'posts',
  published_at: Time.zone.now
).save!

puts '== All Done, have a great day =========='
puts 'Visit http://localhost:3000 and Sign In as: admin@codeandeffect.com with any password'
