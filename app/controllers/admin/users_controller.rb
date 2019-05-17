class Admin::UsersController < Admin::ApplicationController
  include Effective::CrudController

  submit :save, 'Save', only: :edit
  submit :save, 'Continue', only: :edit
  submit :save, 'Add New', only: :edit
  
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
