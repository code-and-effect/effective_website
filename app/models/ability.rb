class Ability
  include CanCan::Ability

  def initialize(user)
    cannot :access, :admin

    user ||= User.new
    effective_abilities!(user)

    can [:edit, :update], User, id: user.id

    if user.is?(:member)
    end

    if user.is?(:admin)
      can :access, :admin
      can :manage, :all
    end
  end

  private

  def effective_abilities!(user)
    can :manage, Effective::Cart, user_id: user.id
    can :manage, Effective::Order, user_id: user.id # Orders cannot be deleted
    can :manage, Effective::Subscription, user_id: user.id # We don't use subscriptions in this app

    can :index, Effective::Log
    can :show, Effective::Page do |page| page.roles_permit?(user) end
    can [:index, :show], Effective::StyleGuide
    can :manage, Effective::Trash, user_id: user.id

    if user.is?(:admin)
      can :manage, Effective::Log
      can :manage, Effective::Menu
      can :manage, Effective::Page
      can :manage, Effective::Region
      can :manage, Effective::Trash

      # Effective Orders
      can :manage, Effective::Order
      can :manage, Effective::Customer
      can :show, :payment_details # Can see the payment purchase details on orders

      can :admin, :effective_logging
      can :admin, :effective_orders
      can :admin, :effective_pages
      can :admin, :effective_roles
      can :admin, :effective_trash
    end
  end

end
