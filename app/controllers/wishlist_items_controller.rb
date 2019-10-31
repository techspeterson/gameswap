class WishlistItemsController < UserProfileController
  before_action :set_user

  def create
    authorize! :create, WishlistItem
    @wishlist_item = WishlistItem.new(wishlist_params)
    @wishlist_item.user = @user
    if @wishlist_item.save
      redirect_to current_user
    else
      render "users/show"
    end
  end

  def destroy
    wishlist_item = WishlistItem.find(params[:wishlist_id])
    if wishlist_item.user == @user
      authorize! :destroy, wishlist_item
      wishlist_item.delete
    end
    redirect_to wishlist_item.user
  end

  private
    def wishlist_params
      params.require(:wishlist_item).permit(:title)
    end

end