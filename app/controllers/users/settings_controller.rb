class Users::SettingsController < ApplicationController
  before_action :authenticate_user!

  before_action { @page_title = 'My Settings' }

  # Get to here by visiting /settings
  def edit
    @user = User.all.deep.find(current_user.id)
    authorize! :edit, @user

    render 'users/settings'
  end

  def update
    @user = current_user
    authorize! :update, @user

    delete_blank_password_params

    if @user.update(permitted_params)
      bypass_sign_in(@user)

      flash[:success] = 'Successfully updated settings.'
      redirect_to user_settings_path
    else
      flash.now[:danger] = "Unable to update settings: #{@user.errors.full_messages.to_sentence}"
      render 'users/settings'
    end
  end

  private

  def permitted_params
    params.require(:user).permit(*User.permitted_sign_up_params,
      files: [],
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
