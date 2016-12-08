# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


puts "== Creating admin user ======================"

user = User.new(
  email: 'admin@codeandeffect.com',
  first_name: 'Admin',
  last_name: 'User',
  password: 'be_effective',
  password_confirmation: 'be_effective'
)
user.roles = :admin
user.save!

user = User.new(
  email: 'admin@agilestyle.com',
  first_name: 'Admin',
  last_name: 'User',
  password: 'be_effective',
  password_confirmation: 'be_effective',
  roles: :admin
)
user.save!

user = User.new(
  email: 'member@codeandeffect.com',
  first_name: 'Member',
  last_name: 'User',
  password: 'be_effective',
  password_confirmation: 'be_effective',
  roles: :member
)
user.save!

user = User.new(
  email: 'guest@codeandeffect.com',
  first_name: 'Guest',
  last_name: 'User',
  password: 'be_effective',
  password_confirmation: 'be_effective',
  roles: nil
)
user.save!

# lib/tasks/generate
Rake::Task['generate:effective_pages'].invoke
Rake::Task['generate:effective_menus'].invoke
