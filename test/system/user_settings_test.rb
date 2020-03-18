require 'application_system_test_case'

class UserSettingsTest < ApplicationSystemTestCase
  let(:member) { User.where(email: 'member@codeandeffect.com').first! }

  test 'can update my settings' do
    as_user(member) do
      visit user_settings_path
      fill_form(email: member.email)
      submit_form
    end
  end

end
