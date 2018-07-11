class Users::SessionsController < Devise::SessionsController
  def new
    super do
      return unless failed_login?

      if User.where(email: params[:user][:email].downcase).exists?
        resource.errors.add(:password, 'is incorrect')
      else
        resource.errors.add(:email, 'not found')
      end
    end
  end

  def failed_login?
    current_user.blank? && params[:action] == 'create' && params[:user] && params[:user][:email]
  end

  def after_sign_in_path_for(user)
    session[:user_return_to] || root_path
  end

end
