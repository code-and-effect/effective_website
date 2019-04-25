# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

puts '== Creating users ======================'

# The webmaster
superadmin = User.create!(email: 'superadmin@codeandeffect.com', name: 'Super Admin', roles: :superadmin, password: 'be_effective')

# The site administrator
admin = User.create!(email: 'admin@codeandeffect.com', name: 'Admin User', roles: :admin, password: 'be_effective')

# Create 3 clients, with 3 users each
3.times do
  client = Client.new(name: Faker::Company.name)

  [:owner, :member, :collaborator].each do |role|
    user = User.create!(email: "#{role}@#{client.name.parameterize}.com", name: Faker::Name.name, roles: :client, password: 'be_effective')
    client.mates.build(user: user, roles: role)
  end

  client.save!
end

# lib/tasks/generate
Rake::Task['generate:effective_pages'].invoke

puts 'Visit http://localhost:3000 and Sign In as: admin@codeandeffect.com with any password'
