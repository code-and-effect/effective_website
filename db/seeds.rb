# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

puts '== Creating users ======================'

User.create!(email: 'admin@codeandeffect.com', name: 'Admin user', password: 'be_effective', roles: :admin)
User.create!(email: 'member@codeandeffect.com', name: 'Member user', password: 'be_effective', roles: :member)
User.create!(email: 'guest@codeandeffect.com', name: 'Normal user', password: 'be_effective')

# lib/tasks/generate
Rake::Task['generate:effective_pages'].invoke
