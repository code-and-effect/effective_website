class Mate < ApplicationRecord
  acts_as_role_restricted  # effective_roles
  log_changes to: :client  # log_changes

  attribute :email

  belongs_to :client, counter_cache: true, autosave: true
  belongs_to :user

  # This is just here to help the mates collection inputs
  # This must be a subset of effective_roles roles. Doesn't interact with roles_masks here.
  ROLES = [:owner, :member, :collaborator]

  effective_resource do
    roles_mask :integer

    email      permitted: true
    roles      permitted: true

    timestamps
  end

  before_validation(if: -> { roles.blank? }) { self.roles = [:member] }

  validates :client, presence: true
  validates :roles, presence: true

  validates :user_id, if: -> { user_id && client_id }, uniqueness: { scope: [:client_id], message: 'already belongs to this client' }

  validate do
    if user_id.blank? && user.blank? && email.blank?
      self.errors.add(:user_id, "please select a user or enter an email address")
      self.errors.add(:email, "please enter an email address")
    end
  end

  before_save(if: -> { user.blank? }) do
    new_user = User.new(email: email)
    new_user.save!(validate: false)

    @invited_user = true
    self.user = new_user
  end

  after_commit(on: :create) do
    @invited_user ? user.invite! : ApplicationMailer.user_invited_to_client(user.id, client.id).deliver_later
  end

  def to_s
    [user.to_s.presence, client.to_s.presence].compact.join(' - ').presence || 'New Mate'
  end

  def invitation_accepted?
    user && user.invitation_accepted?
  end

  def invitation_sent_at
    user && user.invitation_sent_at
  end

  def reinvite!
    save! && user.reinvite!
  end

  def promote!
    case roles.first
    when :collaborator then update(roles: :member)
    when :member then update(roles: :owner)
    else true
    end
  end

  def demote!
    case roles.first
    when :owner then update(roles: :member)
    when :member then update(roles: :collaborator)
    else true
    end
  end

end

