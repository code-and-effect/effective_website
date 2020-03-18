require 'application_system_test_case'

class AdminInviteUserTest < ApplicationSystemTestCase
  let(:admin) { User.where(email: 'admin@codeandeffect.com').first! }
  let(:email) { "newuser@example.com" }

  test 'can create and invite a new user' do
    # Admin creates a new user
    as_user(admin) do
      visit new_admin_user_path
      fill_form(email: email, roles: :admin) and submit_form
      assert_content "sent #{email} an invitation"
    end

    # devise_invitable sent an invitation email
    assert_email(to: email)
    invitation_token = ActionMailer::Base.deliveries.last.body.match(/invitation_token=(.+)\"/)[1]
    assert invitation_token.present?

    # The user was invited
    user = User.where(email: email).first!
    assert user.invitation_sent_at.present?
    assert_equal [:admin], user.roles

    # The user can accept the invitation
    visit accept_user_invitation_path(invitation_token: invitation_token)
    fill_form(email: email) and submit_form
    assert_content I18n.t('devise.invitations.updated')

    # The user is in the correct state after being invited
    user = User.where(email: email).first!
    assert user.invitation_accepted_at.present?
    assert_equal [:admin], user.roles
  end

end
