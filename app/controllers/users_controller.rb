class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:user_id])
    if @user == current_user
      redirect_to my_profile_path
    else
      @wishlist_item = WishlistItem.new
    end
  end

  def my_profile
    @user = current_user
    @wishlist_item = WishlistItem.new
    render :show
  end

end
