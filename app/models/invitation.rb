# This is a form object for the Invite User page

class Invitation
  include ActiveModel::Model

  attr_accessor :user_id, :email, :roles

  validates :email, presence: true, unless: -> { reinvitation? }
  validates :roles, presence: true, unless: -> { reinvitation? }

  validates :user_id, presence: true, if: -> { reinvitation? }

  validate(if: -> { invitation? }) do
    self.errors.add(:email, "#{email} has already been invited") if user.present?
  end

  validate(if: -> { reinvitation? }) do
    self.errors.add(:user_id, 'unable to find user') unless user.present?
  end

  def to_s
    if invitation?
      email
    elsif reinvitation?
      user.email
    else
      'New Invitation'
    end
  end

  def save
    valid?
  end

  def save!
    raise (errors.full_messages.to_sentence.presence || 'invalid') unless save
  end

  def invite!
    User.invite!(email: email, roles: roles)
  end

  def reinvite!
    user.update_column(:invitation_accepted_at, nil)
    user.invite!
  end

  private

  def user
    invitation? ? User.find_by_email(email) : User.find_by_id(user_id)
  end

  def invitation?
    email.present?
  end

  def reinvitation?
    user_id.present?
  end

end
