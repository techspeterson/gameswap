class WishlistItemsController < UsersController
  before_action :set_user, only: [:add_item, :remove_item]
  before_action :check_current_user, only: [:add_item, :remove_item]

  def add_item
    @wishlist_item = @user.wishlist_items.create!(wishlist_params)
    redirect_to user_path(@user)
  end

  def remove_item
    wishlist_item = WishlistItem.find(params[:wishlist_id])
    if wishlist_item.user == @user
      if wishlist_item.user == current_user
        wishlist_item.delete
      end
    end
    redirect_to user_path(@user)
  end

  private
    def wishlist_params
      params.require(:wishlist_item).permit(:title)
    end

end