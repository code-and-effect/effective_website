class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :invitable # :confirmable

  attr_accessor :importing # Skip any Invitation emails

  has_one_attached :avatar  # active_storage
  has_many_attached :files

  acts_as_addressable :billing, :shipping  # effective_addresses
  acts_as_archived                         # effective_resources
  acts_as_role_restricted                  # effective_roles
  log_changes                              # effective_logging

  # My clients
  has_many :mates, -> { order(:id) }, dependent: :destroy, inverse_of: :user
  has_many :clients, -> { Client.sorted }, through: :mates
  accepts_nested_attributes_for :mates

  # If we want to implement client mate roles:
  # has_many :member_mates, -> { with_role(:member) }, class_name: 'Mate', inverse_of: :user
  # has_many :member_clients, through: :member_mates, class_name: 'Client', source: :client

  # This is just here to help the mates collection inputs
  # This must be a subset of effective_roles roles. Doesn't interact with roles_masks here.
  ROLES = [:superadmin, :admin, :client]

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

  scope :deep, -> { includes(:clients) }
  scope :sorted, -> { order(:name) }
  scope :datatables_filter, -> { sorted.select(:name, :id) }

  before_validation(if: -> { roles.blank? }) { self.roles = [:client] }

  # Prepopulate the name based on email
  before_validation(if: -> { email.present? && name.blank? }) do
    self.name = email.split('@').first
  end

  validates :name, presence: true
  validates :roles, presence: true

  validate(if: -> { avatar.attached? }) do
    self.errors.add(:avatar, 'must be an image') unless avatar.image?
  end

  before_save { self.avatar_attached = avatar.attached? }

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
