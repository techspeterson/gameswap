class WishlistItemsController < UserProfileController
  before_action :set_user

  def create
    @wishlist_item = WishlistItem.new(wishlist_params)
    @wishlist_item.user = @user
    authorize! :create, @wishlist_item
    if @wishlist_item.save
      redirect_to user_profile_path(@user)
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
    redirect_to user_profile_path(@user)
  end

  private
    def wishlist_params
      params.require(:wishlist_item).permit(:title)
    end

end