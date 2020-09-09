class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_authorization_check # CanCanCan

  def facebook
    process
  end

  def google_oauth2
    process
  end

  def microsoft_graph
    process
  end

  def process
    @user = User.from_omniauth(request.env['omniauth.auth'], request.env['omniauth.params'])

    if @user.persisted?
      flash[:success] = 'Welcome! Signed in successfully.'
      sign_in_and_redirect @user, event: :authentication
    else
      session["devise.#{@user.provider || 'unknown'}_data"] = request.env['omniauth.auth']
      flash[:danger] ||= "Unable to sign in user: #{@user.errors.full_messages.to_sentence}"

      redirect_to new_user_registration_url
    end
  end

  def failure
    flash[:danger] ||= "Unable to sign in with #{request.env['omniauth.error.strategy'].name}: #{request.env['omniauth.error.type']}. Clear your cookies and try again."
    redirect_to new_user_registration_url
  end

end
