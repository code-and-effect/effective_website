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

  def reinvite
    @user = User.find(params[:id])

    authorize! :reinvite, @user

    if @user.reinvite!
      flash[:success] = "Successfully resent invitation to #{@user.email}"
    else
      flash[:danger] = "Unable to invite: #{@user.errors.full_messages.to_sentence}."
    end

    redirect_back(fallback_location: root_path)
  end

  protected

  def configure_accept_invitation_params
    devise_parameter_sanitizer.permit(:accept_invitation, keys: User.permitted_sign_up_params)
  end

  def after_accept_path_for(resource)
    session[:user_return_to] || root_path
  end

end
