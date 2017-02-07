class Admin::InvitationsController < Admin::ApplicationController
  def new
    @page_title = 'Invite User'

    @invitation = Invitation.new
    authorize! :new, @invitation
  end

  def create
    @invitation = Invitation.new(invitation_params)

    @page_title = 'Invite User'
    authorize! :create, @invitation

    if @invitation.save
      @invitation.invite!
      flash[:success] = "Successfully invited #{@invitation}"
      redirect_to new_admin_invitation_path
    else
      flash.now[:danger] = "Encountered errors with #{@invitation.errors.keys.map(&:to_s).to_sentence}. No invitation emails have been sent. Please try again."
      render :new
    end
  end

  protected

  def invitation_params
    params.require(:invitation).permit(*User.permitted_sign_up_params, :emails, roles: [])
  end

end
