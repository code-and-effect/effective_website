class Users::ImpersonationsController < ApplicationController
  before_action :authenticate_user!
  skip_authorization_check only: [:destroy]

  def destroy
    @user = User.find(session[:impersonation_user_id])

    # Reset impersonation
    session[:impersonation_user_id] = nil
    expire_data_after_sign_in!
    warden.session_serializer.store(@user, Devise::Mapping.find_scope!(@user))

    redirect_to(admin_users_path)
  end

end
