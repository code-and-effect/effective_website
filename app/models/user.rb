class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :invitable # :confirmable

  acts_as_addressable :billing, :shipping  # effective_addresses
  acts_as_archived                         # effective_resources
  acts_as_role_restricted                  # effective_roles
  log_changes                              # effective_logging

  # This must be a subset of effective_roles roles.
  ROLES = [:admin, :staff, :client]

  has_one_attached :avatar  # active_storage
  has_many_attached :files

  # My clients
  has_many :mates, -> { order(:id) }, dependent: :destroy, inverse_of: :user
  has_many :clients, -> { Client.sorted }, through: :mates
  accepts_nested_attributes_for :mates

  # If we want to implement client mate roles:
  # has_many :member_mates, -> { with_role(:member) }, class_name: 'Mate', inverse_of: :user
  # has_many :member_clients, through: :member_mates, class_name: 'Client', source: :client

  def self.permitted_sign_up_params # Should contain all fields as per views/users/_sign_up_fields
    [:email, :password, :password_confirmation, :name]
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

    email                   :string
    name                    :string
    avatar_attached         :boolean

    roles_mask              :integer, permitted: false
    roles                   permitted: true

    archived                :boolean, permitted: false

    timestamps
  end

  scope :deep, -> { with_attached_files.includes(:clients) }
  scope :shallow, -> { select(:id, :email, :name) }

  scope :sorted, -> { order(:name) }
  scope :datatables_filter, -> { sorted.shallow }

  scope :admins, -> { unarchived.with_role(:admin) }
  scope :staff, -> { unarchived.with_role(:staff) }
  scope :clients, -> { unarchived.with_role(:client) }

  before_validation(if: -> { roles.blank? }) { self.roles = [:client] }



  validates :name, presence: true
  validates :roles, presence: true

  validate(if: -> { avatar.attached? }) do
    self.errors.add(:avatar, 'must be an image') unless avatar.image?
  end

  # Prepopulate the name based on email
  before_save(if: -> { email.present? && name.blank? }) do
    self.name = email.split('@').first
  end

  before_save { self.avatar_attached = avatar.attached? }

  # Devise invitable ignores model validations, so we manually check for duplicate email addresses.
  before_save(if: -> { new_record? && invitation_sent_at.present? }) do
    if self.class.where(email: email).exists?
      self.errors.add(:email, 'has already been taken')
      throw(:abort)
    end
  end

  def to_s
    name.presence || email
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
