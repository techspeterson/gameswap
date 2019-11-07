# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    alias_action :create, :read, :update, :destroy, to: :crud

    can :read, Listing

    if user.present?
      can :read, User
      can :crud, User, id: user.id
      can :crud, [Listing, UserDetail, Address, WishlistItem], user_id: user.id
      cannot :create, Listing if !user.address

      if user.is_admin
        can :manage, :all
      end
    end
  end
end
