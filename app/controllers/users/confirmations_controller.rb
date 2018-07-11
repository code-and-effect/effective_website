class Users::ConfirmationsController < Devise::ConfirmationsController
  protected

  def after_resending_confirmation_instructions_path_for(resource_name)
    request.referer.to_s.end_with?('/settings') ? user_settings_path : super
  end

  def after_confirmation_path_for(resource_name, resource)
    sign_in(resource) and root_path
  end

end
