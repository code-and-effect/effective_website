puts '== Creating test users ================='
member = User.create!(email: 'member@codeandeffect.com', first_name: 'Member', last_name: 'User', password: 'example')
