class UserProfileController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def show
    authorize! :read, @user
    @wishlist_item = WishlistItem.new
  end

  def listings
    authorize! :read, @user
  end

  private
    def set_user
      @user = User.find(params[:user_id])
    end
end
