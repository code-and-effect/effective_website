require 'test_helper'

class UsersTest < ActiveSupport::TestCase
  let(:user) { User.new }

  test 'build_user factory' do
    assert build_user().valid?
    assert build_user_with_address().valid?
  end

  test 'archived users are inactive for authentication' do
    user = User.new()
    assert user.active_for_authentication?

    user.assign_attributes(archived: true)
    refute user.active_for_authentication?
  end

  test "email can't be blank" do
    user = User.new(first_name: 'First', last_name: 'Last', roles: [])
    refute user.save
    assert user.errors[:email].present?
  end

  test "devise invitable email can't be blank" do
    user = User.new()

    exception = assert_raises(Exception) { user.invite! }
    assert_equal "email can't be blank", exception.message
    assert_equal "can't be blank", user.errors[:email].first
  end

  test "devise invitable email must be unique" do
    existing = User.where(email: 'admin@codeandeffect.com').first!

    user = User.new(email: 'admin@codeandeffect.com')
    exception = assert_raises(Exception) { user.invite! }
    assert_equal "email has already been taken", exception.message
    assert_equal "has already been taken", user.errors[:email].first
  end

end
