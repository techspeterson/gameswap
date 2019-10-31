class UserProfileController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:user_id])
    authorize! :read, @user
    @wishlist_item = WishlistItem.new
  end

  private
    def set_user
      @user = User.find(params[:user_id])
    end
end
