class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :invitable

  acts_as_addressable :billing, :shipping
  acts_as_asset_box :files
  acts_as_role_restricted
  acts_as_trashable

  def self.permitted_sign_up_params # Should contain all fields as per views/users/_sign_up_fields
    [:email, :password, :password_confirmation, :first_name, :last_name]
  end

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

  # timestamps

  def full_name
    [first_name.presence, last_name.presence].compact.join(' ')
  end

  def to_s
    email
  end

  def valid_password?(password)
    Rails.env.development? || super  # Any password will work in development mode
  end

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later # Send devise & devise_invitable emails via active job
  end

end
