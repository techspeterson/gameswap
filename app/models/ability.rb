# frozen_string_literal: true

# cancancan permissions go here

class Ability
  include CanCan::Ability

  def initialize(user)
    alias_action :create, :read, :update, :destroy, to: :crud

    # users do not have to be logged in to browse listings
    can :read, Listing

    if user.present?
      can :read, User
      can :crud, User, id: user.id
      can :crud, [Listing, UserDetail, Address, WishlistItem], user_id: user.id
      cannot :create, Listing if !user.address # user needs a shipping address to create a listing
      cannot :update, Listing, is_sold: true # listings cannot be edit once they have been sold

      if user.is_admin
        can :manage, :all
      end
    end
  end
end
