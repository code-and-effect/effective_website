class Ability
  include CanCan::Ability

  def initialize(user)
    cannot :access, :admin

    user ||= User.new

    # Account / Shared abilities
    can [:edit, :update], User, id: user.id

    # Effective Gems
    can [:index, :show], Effective::Post
    can [:index, :show], Effective::StyleGuide

    can :index, Effective::Page
    can(:show, Effective::Page) { |page| page.roles_permit?(user) }

    if user.is?(:client)
      client_abilities(user)
    end

    if user.is?(:staff)
      staff_abilities(user)
    end

    if user.is?(:admin)
      staff_abilities(user)
      admin_abilities(user)
    end
  end

  private

  def client_abilities(user)
    can :manage, Effective::Cart, user_id: user.id
    can :manage, Effective::Order, user_id: user.id # Orders cannot be deleted

    # My Clients
    can [:index, :show, :edit], Client, id: user.client_ids
    can :update, Client, id: user.client_ids(:owner)
    can [:destroy, :transfer], Client, id: user.client_ids(:owner)

    # My Mates
    can([:new, :create], Mate) { |mate| user.client_ids(:owner, :member).include?(mate.client_id) }
    can(:index, Mate) { |mate| user.client_ids(:owner, :member).include?(mate.client_id) }
    can(:show, Mate) { |mate| user.client_ids(:owner, :member).include?(mate.client_id) || mate.user_id == user.id }
    can(:destroy, Mate) { |mate| user.client_ids(:owner).include?(mate.client_id) || (!mate.is?(:owner) && mate.user_id == user.id) }
    can(:promote, Mate) { |mate| user.client_ids(:owner).include?(mate.client_id) && !mate.is?(:owner) && mate.user_id != user.id }
    can(:demote, Mate) { |mate| user.client_ids(:owner).include?(mate.client_id) && !mate.is?(:collaborator) && mate.user_id != user.id }
    can(:reinvite, Mate) { |mate| user.client_ids(:owner, :member).include?(mate.client_id) && !mate.invitation_accepted? }
  end

  def staff_abilities(user)
    can :access, :admin

    # Effective Gems
    can [:new, :create, :edit, :update, :destroy], Effective::Page
    can :manage, Effective::CkAsset
    can :manage, Effective::Log
    can :manage, Effective::Post
    can :manage, Effective::Region

    can :manage, Effective::Order
    can :show, :payment_details # Can see the payment purchase details on orders

    can :admin, :effective_logging
    can :admin, :effective_orders
    can :admin, :effective_pages
    can :admin, :effective_posts
    can :admin, :effective_roles

    # Clients
    can(crud, Client)
    acts_as_archived(Client)
    can(:transfer, Client) { |client| user.client_ids(:owner).include?(client.id) }

    # Mates
    can(crud, Mate)
    can(:promote, Mate) { |mate| !mate.is?(:owner) }
    can(:demote, Mate) { |mate| !mate.is?(:collaborator) }
    can(:reinvite, Mate) { |mate| !mate.invitation_accepted? }

    # Users
    can(crud, User)
    acts_as_archived(User)
    can(:impersonate, User) { |user| user.is?(:client) }
    can(:invite, User) { |user| user.new_record? }
    can(:reinvite, User) { |user| !user.invitation_accepted? || user.invitation_sent_at.blank? }
  end

  def admin_abilities(user)
    can(:impersonate, User) { |user| user.is?(:client) || user.is?(:staff) }
  end

end
