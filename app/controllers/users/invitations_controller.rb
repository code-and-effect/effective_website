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
    @invitation = Invitation.new(user_id: params[:id])

    authorize! :reinvite, @invitation

    if @invitation.save
      @invitation.reinvite!
      flash[:success] = "Successfully resent invitation to #{@invitation}"
    else
      flash[:danger] = "Unable to invite: #{@invitation.errors.full_messages.to_sentence}."
    end

    redirect_back(fallback_location: root_path)
  end

  protected

  def configure_accept_invitation_params
    devise_parameter_sanitizer.permit(:accept_invitation, keys: User.permitted_sign_up_params)
  end

  def after_accept_path_for(resource)
    root_path
  end

end
