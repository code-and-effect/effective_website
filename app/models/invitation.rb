require 'csv'

# This is a form object for the Invite User page

class Invitation
  include ActiveModel::Model

  EMAILS_LIMIT = 200 # The emails are sent via active job.  We should set a reasonable upper limit tho.

  attr_accessor :user_id, :email, :emails, :roles
  attr_reader :invitations

  validates :email, presence: true, unless: -> { reinvitation? || bulk? }
  validates :roles, presence: true, unless: -> { reinvitation? }

  validates :user_id, presence: true, if: -> { reinvitation? }

  validate(if: -> { invitation? }) do
    self.errors.add(:email, "#{email} has already been invited") if user.present?
  end

  validate(if: -> { reinvitation? }) do
    self.errors.add(:user_id, 'unable to find user') unless user.present?
  end

  validate(if: -> { bulk? }) do
    @invitations = []
    index = 0

    begin
      CSV.parse(emails) do |row|
        unless row[0].kind_of?(String) && row[0].include?('@') && row[0].include?('.')
          self.errors.add(:emails, "[Line #{index+1}] invalid line: #{row.join(',')}")
          break
        end

        @invitations << { email: row[0].to_s.strip, name: row[1].to_s.strip }

        index += 1
      end

      self.errors.add(:emails, "contains more than #{EMAILS_LIMIT} lines") if @invitations.length > EMAILS_LIMIT
    rescue => e
      self.errors.add(:emails, "Error encountered on line #{index+1}: #{e.message}")
    end
  end

  def to_s
    if invitations.present?
      "#{invitations.length + (email.present? ? 1 : 0)} users"
    elsif invitation?
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
    raise "invalid #{errors.keys.join(', ')}" unless save
  end

  def invite!
    if invitation?
      User.invite!(email: email, roles: roles)
    end

    (invitations || []).each do |invitation|
      User.invite!(invitation.merge(roles: roles))
    end

    true
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

  def bulk?
    emails.present?
  end

  def reinvitation?
    user_id.present?
  end

end
