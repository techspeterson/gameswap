class UserProfileController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :listings]

  def show
    authorize! :read, @user
    @wishlist_item = WishlistItem.new(user: @user)
  end

  def listings
    authorize! :read, @user
  end

  def dashboard
  end

  private
    def set_user
      @user = User.find(params[:user_id])
    end
end
