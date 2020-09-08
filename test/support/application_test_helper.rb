module ApplicationTestHelper

  def build_user
    @user_index ||= 0
    @user_index += 1

    User.create!(
      email: "user#{@user_index}@example.com",
      password: 'rubicon2020',
      password_confirmation: 'rubicon2020',
      first_name: 'Test',
      last_name: 'User'
    )
  end

  def build_user_with_address
    user = build_user()

    user.addresses.build(
      addressable: user,
      category: 'billing',
      full_name: 'Test User',
      address1: '1234 Fake Street',
      city: 'Victoria',
      state_code: 'BC',
      country_code: 'CA',
      postal_code: 'H0H0H0'
    )

    user.save!
    user
  end

  def with_time_travel(date, &block)
    begin
      Timecop.travel(date)
      yield
    ensure
      Timecop.return
    end
  end

end
