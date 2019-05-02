module ApplicationHelper
  def user_tag(user, name: true)
    user ||= User.new

    avatar_tag = if user.avatar_attached? && user.avatar.attached? && (url = url_for(user.avatar) rescue false)
      content_tag(:span, class: 'user-avatar', title: user.to_s) { image_tag(url, alt: user.to_s) }
    end

    name_tag = content_tag(:span, user.to_s, class: 'user-name')

    [(avatar_tag if avatar_tag.present?), (name_tag if avatar_tag.blank? || name)].compact.join(' ').html_safe
  end
end
