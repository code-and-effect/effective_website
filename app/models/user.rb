class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :invitable

  acts_as_addressable :billing, :shipping
  acts_as_asset_box :files
  acts_as_role_restricted

  # Attributes
  # encrypted_password      :string
  # reset_password_token    :string
  # reset_password_sent_at  :datetime
  # remember_created_at     :datetime
  # sign_in_count           :integer
  # current_sign_in_at      :datetime
  # last_sign_in_at         :datetime
  # current_sign_in_ip      :inet
  # last_sign_in_ip         :inet

  # Devise invitable attributes
  # invitation_token        :string
  # invitation_created_at   :datetime
  # invitation_sent_at      :datetime
  # invitation_accepted_at  :datetime
  # invitation_limit        :integer
  # invited_by_type         :string
  # invited_by_id           :integer
  # invitations_count       :integer

  # email                   :string
  # first_name              :string
  # last_name               :string

  # roles_mask              :integer
  # archived                :boolean, default: false, validates: [:boolean]

  # timestamps

  def full_name
    [first_name.presence, last_name.presence].compact.join(' ')
  end

  def to_s
    email
  end

  def destroy
    update_column(:archived, true) # This intentionally skips validation
  end

  def unarchive
    update_column(:archived, false) # This intentionally skips validation
  end

  # Devise methods
  def active_for_authentication?
    super && archived != true
  end

  def inactive_message
    archived ? 'This account has been archived. You will be unable to login. Please contact an administrator for assistance.' : super
  end

  def valid_password?(password)
    Rails.env.development? || super  # Any password will work in development mode
  end

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later # Send devise & devise_invitable emails via active job
  end

end
