class Users::ImpersonationsController < ApplicationController
  before_action :authenticate_user!

  skip_authorization_check only: [:destroy]

  def create
    @user = User.where(id: params[:id]).first

    authorize! :impersonate, @user

    if @user.is?(:admin)
      flash[:danger] = 'Unable to impersonate an admin user'
      redirect_back(fallback_location: root_path) and return
    end

    session[:impersonation_user_id] ||= current_user.id
    impersonate_sign_in(@user)

    redirect_to(root_path)
  end

  def destroy
    if session[:impersonation_user_id].present?
      @user = User.find(session[:impersonation_user_id])

      session[:impersonation_user_id] = nil
      impersonate_sign_in(@user)
    end

    redirect_to(root_path)
  end

  private

  def impersonate_sign_in(resource, scope: nil)
    scope ||= Devise::Mapping.find_scope!(resource)
    expire_data_after_sign_in!
    warden.session_serializer.store(resource, scope)
  end

end
