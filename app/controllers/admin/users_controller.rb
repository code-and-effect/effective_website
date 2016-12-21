class Admin::UsersController < Admin::ApplicationController
  def index
    authorize! :index, User

    @page_title = 'Users'
    @datatable = Effective::Datatables::Users.new
  end

  def new
    @user = User.new
    authorize! :new, @user

    @page_title = 'Create User'
  end

  def create
    @user = User.new(user_params)
    authorize! :create, @user

    @page_title = 'Create User'

    if @user.save
      flash[:success] = "User registered! The user has *not* been notified by email"
      redirect_to admin_users_path
    else
      flash.now[:danger] = 'Unable to create user'
      render action: :new
    end
  end

  def edit
    @user = User.find(params[:id])
    authorize! :edit, @user

    @page_title = "Edit #{@user}"
  end

  def update
    @user = User.find(params[:id])
    authorize! :update, @user

    @page_title = "Edit #{@user}"

    @user.attributes = user_params

    if @user.save
      flash[:success] = 'Successfully updated user'
      redirect_to edit_admin_user_path(@user)
    else
      flash.now[:danger] = 'Unable to update user'
      render action: :new
    end
  end

  def destroy
    @user = User.find(params[:id])
    authorize! :destroy, @user

    if @user.destroy
      flash[:success] = 'Successfully deleted user'
    else
      flash[:danger] = "Unable to delete user: #{@user.errors.full_messages.to_sentence}"
    end

    redirect_to admin_users_path
  end

  def unarchive
    @user = User.find(params[:id])
    authorize! :unarchive, @user

    @user.unarchive
    flash[:success] = 'Successfully unarchived user'

    redirect_to(admin_users_path)
  end

  private

  def user_params
    if params[:user] && params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end

    params.require(:user).permit(
      :email, :password, :password_confirmation, :first_name, :last_name,
      EffectiveAssets.permitted_params,
      EffectiveRoles.permitted_params,
      billing_address: EffectiveAddresses.permitted_params,
      shipping_address: EffectiveAddresses.permitted_params
    )
  end
end
