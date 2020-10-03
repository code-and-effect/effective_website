require 'application_system_test_case'

class UserDeviseTest < ApplicationSystemTestCase
  let(:member) { User.where(email: 'member@codeandeffect.com').first! }

  test 'oauth forgot your password confirmation' do
    member.update!(provider: 'facebook')

    visit new_user_password_path

    within('#new_user') do
      fill_form(email: member.email)
      submit_novalidate_form
    end

    assert_content('previous sign in was with facebook')

    within("#edit_user_#{member.id}") do
      fill_form(email: member.email, confirm_new_password: true)
      submit_form
    end

    assert_content I18n.t('devise.passwords.send_instructions')
  end

end
