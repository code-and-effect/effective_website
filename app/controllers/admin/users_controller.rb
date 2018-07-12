class Admin::UsersController < Admin::ApplicationController
  include Effective::CrudController

  protected

  def user_params
    if params[:user] && params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end

    params.require(:user).permit!
  end
end
