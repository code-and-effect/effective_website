class Users::InvitationsController < Devise::InvitationsController
  before_action :configure_accept_invitation_params, only: [:update]
  before_action :authenticate_user!, only: [:create]

  # We disable the default new action
  def new
    raise CanCan::AccessDenied
  end

  def create
    raise CanCan::AccessDenied
  end

  protected

  def configure_accept_invitation_params
    devise_parameter_sanitizer.permit(:accept_invitation, keys: User.permitted_sign_up_params)
  end

  def after_accept_path_for(resource)
    session[:user_return_to] || root_path
  end

end
