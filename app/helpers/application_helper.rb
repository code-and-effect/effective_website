module ApplicationHelper

  def impersonating?
    session[:impersonation_user_id].present?
  end

  def gravatar_url(user)
    hash = Digest::MD5.hexdigest(user.email)
    "https://secure.gravatar.com/avatar/#{hash}.png?d=blank"
  end

  def user_tag(user)
    user ||= User.new()

    gravatar = image_tag(gravatar_url(user), alt: user.to_s, class: 'user-avatar')
    contents = content_tag(:span, user.to_s, class: 'user-name')

    (gravatar + contents)
  end

end
