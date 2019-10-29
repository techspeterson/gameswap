class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:edit_profile, :update_profile, :add_wishlist_item, :remove_wishlist_item]

  def show
    @user = User.find(params[:id])
    if !@user
      redirect_to root_path
    end

    @wishlist_item = WishlistItem.new
  end

  def edit_profile
  end

  # def update
  #   if @user.user_detail.update(user_params)
  #     redirect_to @user
  #   else
  #     render :edit
  #   end
  # end

  def update_profile
    if @user.user_detail.update(user_params)
      redirect_to @user
    else
      render :edit
    end
  end

  def add_wishlist_item
    @wishlist_item = @user.wishlist_items.create!(wishlist_params)
    redirect_to user_path(@user)
  end

  def remove_wishlist_item
    wishlist_item = WishlistItem.find(params[:wishlist_id])
    if wishlist_item.user == @user
      if wishlist_item.user == current_user
        wishlist_item.delete
      end
    end
    redirect_to user_path(@user)
  end

  private

    def set_user
      @user = User.find(params[:id])
      if @user != current_user
        redirect_to root_path
      end
    end

    def user_params
      params.require(:user_detail).permit(:bio)
    end

    def address_params
      params.require(:address).permit(:address_line_1, :address_line_2, :city, :state, :country_id, :postcode)
    end

    def wishlist_params
      params.require(:wishlist_item).permit(:title)
    end
end
