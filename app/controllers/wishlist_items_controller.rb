class WishlistItemsController < UserProfileController
  before_action :set_user

  def create
    @wishlist_item = WishlistItem.new(wishlist_params)
    @wishlist_item.user = @user
    authorize! :create, @wishlist_item

    if @wishlist_item.save
      redirect_to user_profile_path(@user), notice: "Wishlist item added: #{@wishlist_item.title}"
    else
      render "users/show"
    end
  end

  def destroy
    wishlist_item = WishlistItem.find(params[:wishlist_id])

    # check that the wishlist from the params matches the user from the params
    if wishlist_item.user == @user
      authorize! :destroy, wishlist_item
      wishlist_item.delete
      redirect_to user_profile_path(@user), notice: "Wishlist item removed: #{wishlist_item.title}"
    else
      redirect_to user_profile_path(@user)
    end
  end

  private
    # permitted params for wishlist item: title
    def wishlist_params
      params.require(:wishlist_item).permit(:title)
    end
end