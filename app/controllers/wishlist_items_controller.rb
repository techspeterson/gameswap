class WishlistItemsController < ApplicationController

  def add_item
    @wishlist_item = WishlistItem.new(wishlist_params)
    @wishlist_item.user = current_user
    if @wishlist_item.save
      redirect_to current_user
    else
      @user = current_user
      render "users/show"
    end
  end

  def remove_item
    wishlist_item = WishlistItem.find(params[:wishlist_id])
    if wishlist_item.user == current_user
      wishlist_item.delete
    end
    redirect_to wishlist_item.user
  end

  private
    def wishlist_params
      params.require(:wishlist_item).permit(:title)
    end

end