# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


puts "== Creating admin user ======================"

user = User.new(
  email: 'admin@agilestyle.com',
  first_name: 'Agile',
  last_name: 'Style',
  password: 'be_effective',
  password_confirmation: 'be_effective'
)
user.roles = [:admin] if user.respond_to?(:roles)
user.save!

# lib/tasks/generate
Rake::Task['generate:effective_pages'].invoke
Rake::Task['generate:effective_menus'].invoke
