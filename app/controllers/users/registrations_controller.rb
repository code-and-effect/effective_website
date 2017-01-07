class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: User.permitted_sign_up_params)
  end

  def after_sign_up_path_for(resource)
    root_path
  end

end
