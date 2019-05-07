class Admin::UsersController < Admin::ApplicationController
  include Effective::CrudController

  submit :save, false, only: :new
  
  submit :invite, 'Save and Invite', only: :new, class: 'btn btn-primary', 
    success: -> { "Successfully created #{resource} and sent #{resource.email} an invitation" }

  def impersonate
    @user = User.find(params[:id])

    authorize! :impersonate, @user

    # Impersonate
    session[:impersonation_user_id] = current_user.id
    expire_data_after_sign_in!
    warden.session_serializer.store(@user, Devise::Mapping.find_scope!(@user))

    redirect_to(root_path)
  end

end
