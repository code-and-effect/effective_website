require 'application_system_test_case'

class DashboardTest < ApplicationSystemTestCase
  let(:member) { User.where(email: 'member@codeandeffect.com').first! }

  test 'can visit the dashboard' do
    as_user(member) do
      visit root_path
      assert_content 'Dashboard'
      assert_content member.to_s
    end
  end

end
