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
    if current_user.user_detail.is_admin
      @users = User.order("username")
      render :admin_dashboard
    elsif params[:sold]
      @sold = true
      @listings = current_user.listings.where("is_sold is true")
    else
      @sold = false
      @listings = current_user.listings.where("is_sold is false")
    end
  end

  private
    def set_user
      @user = User.find(params[:user_id])
    end
end
