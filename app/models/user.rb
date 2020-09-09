class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable,
    :invitable, :omniauthable, omniauth_providers: []

  acts_as_addressable :billing, :shipping  # effective_addresses
  acts_as_archived                         # effective_resources
  acts_as_role_restricted                  # effective_roles
  log_changes                              # effective_logging

  # This must be a subset of effective_roles roles.
  ROLES = [:admin, :staff, :client]
  has_many_attached :files

  # My clients
  has_many :mates, -> { order(:id) }, dependent: :destroy, inverse_of: :user
  has_many :clients, -> { Client.sorted }, through: :mates
  accepts_nested_attributes_for :mates

  # If we want to implement client mate roles:
  # has_many :member_mates, -> { with_role(:member) }, class_name: 'Mate', inverse_of: :user
  # has_many :member_clients, through: :member_mates, class_name: 'Client', source: :client

  def self.permitted_sign_up_params # Should contain all fields as per views/users/_sign_up_fields
    [:email, :password, :password_confirmation, :first_name, :last_name]
  end

  effective_resource do
    encrypted_password      :string
    reset_password_token    :string
    reset_password_sent_at  :datetime
    remember_created_at     :datetime
    sign_in_count           :integer
    current_sign_in_at      :datetime
    last_sign_in_at         :datetime
    current_sign_in_ip      :inet
    last_sign_in_ip         :inet

    # Devise invitable attributes
    invitation_token        :string
    invitation_created_at   :datetime
    invitation_sent_at      :datetime
    invitation_accepted_at  :datetime
    invitation_limit        :integer
    invited_by_type         :string
    invited_by_id           :integer
    invitations_count       :integer

    # Demographics
    email                   :string
    first_name              :string
    last_name               :string

    # Omniauth
    uid                     :string
    provider                :string

    name                    :string
    avatar_url              :string

    access_token            :string
    refresh_token           :string
    token_expires_at        :datetime

    # Internal
    roles_mask              :integer, permitted: false
    roles                   permitted: true

    archived                :boolean, permitted: false

    timestamps
  end

  scope :deep, -> { with_attached_files.includes(:clients) }
  scope :shallow, -> { select(:id, :email, :first_name, :last_name) }

  scope :sorted, -> { order(:first_name) }
  scope :datatables_filter, -> { sorted.shallow }

  scope :admins, -> { unarchived.with_role(:admin) }
  scope :staff, -> { unarchived.with_role(:staff) }
  scope :clients, -> { unarchived.with_role(:client) }

  before_validation(if: -> { roles.blank? }) { self.roles = [:client] }

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :roles, presence: true

  # Devise invitable ignores model validations, so we manually check for duplicate email addresses.
  before_save(if: -> { new_record? && invitation_sent_at.present? }) do
    if email.blank?
      self.errors.add(:email, "can't be blank")
      raise("email can't be blank")
    end

    if self.class.where(email: email.downcase.strip).exists?
      self.errors.add(:email, 'has already been taken')
      raise("email has already been taken")
    end
  end

  def self.from_omniauth(auth, params)
    invitation_token = (params.presence || {})['invitation_token']

    email = (auth.info.email.presence || "#{auth.uid}@#{auth.provider}.none").downcase
    image = auth.info.image
    name = auth.info.name || auth.dig(:extra, :raw_info, :login)
    info = auth.dig(:extra, :raw_info).to_h.symbolize_keys

    user = if invitation_token
      User.find_by_invitation_token(invitation_token, false) || raise(ActiveRecord::RecordNotFound)
    else
      User.where(uid: auth.uid, provider: auth.provider).or(User.where(email: email)).first || User.new
    end

    user.assign_attributes(
      uid: auth.uid,
      provider: auth.provider,
      email: email,
      avatar_url: image,
      name: name,
      first_name: auth.info.first_name.presence || name.split(' ').first,
      last_name: auth.info.last_name || name.split(' ').last
    )

    if auth.respond_to?(:credentials)
      user.assign_attributes(
        access_token: auth.credentials.token,
        refresh_token: auth.credentials.refresh_token,
        token_expires_at: Time.zone.at(auth.credentials.expires_at), # We are given integer datetime e.g. '1549394077'
      )
    end

    # Make a password
    user.password = Devise.friendly_token[0, 20] if user.encrypted_password.blank?

    invitation_token ? user.accept_invitation! : user.save!

    user.confirm

    user
  end

  def to_s
    name.presence || full_name.presence || email
  end

  def full_name
    [first_name, last_name].compact.join(' ')
  end

  def reinvite!
    invite!
  end

  def active_for_authentication?
    super && !archived?
  end

  def inactive_message
    archived? ? :archived : super
  end

  def valid_password?(password)
    Rails.env.development? || Rails.env.staging? || super  # Any password will work in development mode
  end

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later # Send devise & devise_invitable emails via active job
  end

  # user.client_ids
  # user.client_ids(:owner)
  # user.client_ids(:member)
  def client_ids(*role_names)
    @client_ids ||= mates.to_a.group_by { |mate| mate.roles.first }.transform_values { |mates| mates.map(&:client_id) }
    role_names.present? ? (Array(role_names).flat_map { |role| @client_ids[role] }.compact) : @client_ids.values.flatten
  end

end
