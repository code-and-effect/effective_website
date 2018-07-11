module ApplicationHelper
  def user_tag(user, name: false)
    user ||= User.new

    avatar = if user.avatar_attached? && user.avatar.attached? && (url = url_for(user.avatar) rescue false)
      content_tag(:span, class: 'user-avatar', title: user.to_s) do
        image_tag(url, alt: user.to_s)
      end
    else
      content_tag(:span, user.to_s, title: user.to_s)
    end

    name ? (avatar + ' ' + content_tag(:span, user.to_s, class: 'user-name')) : avatar
  end
end
