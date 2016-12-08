class UserSettingsController < ApplicationController
  before_action :authenticate_user!

  # Get to here by visiting /settings
  def edit
    @user = current_user
    authorize! :edit, @user

    @page_title = 'Account Settings'
  end

  def update
    @user = current_user
    authorize! :update, @user

    @page_title = 'Account Settings'

    delete_blank_password_params

    if @user.update(permitted_params)
      bypass_sign_in(@user)

      flash[:success] = 'Successfully updated account settings.'
      redirect_to user_settings_path
    else
      flash.now[:danger] = "Unable to update account settings: #{@user.errors.full_messages.to_sentence}"
      render :edit
    end
  end

  private

  def permitted_params
    params.require(:user).permit(
      :email, :password, :password_confirmation, :first_name, :last_name,
      EffectiveAssets.permitted_params,
      billing_address: EffectiveAddresses.permitted_params,
      shipping_address: EffectiveAddresses.permitted_params
    )
  end

  def delete_blank_password_params
    if params[:user] && params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
  end

end
