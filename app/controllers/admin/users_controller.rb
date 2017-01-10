class Admin::UsersController < Admin::ApplicationController
  include Effective::CrudController

  protected

  def user_params
    if params[:user] && params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end

    params.require(:user).permit(*User.permitted_sign_up_params,
      EffectiveAssets.permitted_params,
      EffectiveRoles.permitted_params,
      billing_address: EffectiveAddresses.permitted_params,
      shipping_address: EffectiveAddresses.permitted_params
    )
  end
end
