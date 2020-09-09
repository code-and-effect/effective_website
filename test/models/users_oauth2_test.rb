require 'test_helper'

class UsersOauth2Test < ActiveSupport::TestCase
  # Using OpenStruct because I need the auth.info.email syntax
  let(:auth) do
    OpenStruct.new({
      uid: 123,
      provider: 'test',
      info: OpenStruct.new({
        email: 'newb@test.com',
        first_name: 'First',
        last_name: 'Last'
      }),
      credentials: OpenStruct.new({
        token: 'access',
        refresh_token: 'refresh',
        expires_at: 1599688467
      })
    })
  end

  test 'create a user from oauth' do
    user = User.from_omniauth(auth, {})
    assert user.persisted?

    assert_equal '123', user.uid
    assert_equal 'newb@test.com', user.email
    assert_equal 'test', user.provider

    assert_equal 'access', user.access_token
    assert_equal 'refresh', user.refresh_token

    assert user.encrypted_password.present?
  end

  test 'create a user from oauth when invited' do
    invitee = User.invite!(email: 'newb@test.com')
    user = User.from_omniauth(auth, {'invitation_token': invitee.invitation_token})

    assert_equal invitee.id, user.id
  end

  test 'provider is nil after password reset' do
    user = User.from_omniauth(auth, {})
    assert user.persisted?
    assert user.encrypted_password.present?
    assert user.provider.present?

    user.update!(password: 'newpassword')
    assert user.provider.blank?
  end

end
