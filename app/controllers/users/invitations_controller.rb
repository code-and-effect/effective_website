class Users::InvitationsController < Devise::InvitationsController
  before_action :configure_accept_invitation_params, only: [:create, :update]
  before_action :authenticate_user!, only: [:create]

  # We disable the default new action
  def new
    raise CanCan::AccessDenied
  end

  def create
    @invitation = Invitation.new(invitation_params)

    authorize! :create, @invitation

    if @invitation.save
      @invitation.invite!
      flash[:success] = "Successfully invited #{@invitation}"
    else
      flash[:danger] = "Unable to invite: #{@invitation.errors.full_messages.to_sentence}.  Please click resend invitation instead."
    end

    redirect_to (request.referer.present? ? :back : root_path)
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

    redirect_to (request.referer.present? ? :back : root_path)
  end

  protected

  def invitation_params
    params.require(:invitation).permit(:email, :first_name, :last_name, roles: [])
  end

  def configure_accept_invitation_params
    devise_parameter_sanitizer.permit(:accept_invitation, keys: [
      :email, :password, :password_confirmation, :first_name, :last_name
    ])
  end

  def after_accept_path_for(resource)
    root_path
  end

end
