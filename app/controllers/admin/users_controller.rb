class Admin::UsersController < Admin::ApplicationController
  include Effective::CrudController

  def impersonate
    @user = User.find(params[:id])

    authorize! :impersonate, @user

    # Impersonate
    session[:impersonation_user_id] ||= current_user.id
    expire_data_after_sign_in!
    warden.session_serializer.store(@user, Devise::Mapping.find_scope!(@user))

    redirect_to(root_path)
  end

  protected

  def user_params
    if params[:user] && params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end

    params.require(:user).permit!
  end
end
