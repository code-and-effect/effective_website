require 'application_system_test_case'

class SignUpTest < ApplicationSystemTestCase
  test 'sign up and build team wizard' do
    # Sign up via Devise
    sign_up
    assert_page_normal
    assert_equal root_path, page.current_path
    assert_signed_in
  end

end
