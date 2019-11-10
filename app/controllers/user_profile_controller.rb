class UserProfileController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :listings]

  # views for user profiles and the dashboard
  # addresses, user_details and wishlist_items controllers inherit from this one
  # (to make use of set_user method and authentication)

  def show
    authorize! :read, @user
    # since wishlist items are added from the user profile, a blank one is initialised here
    # (though the form won't be displayed if the user isn't authorised to add wishlist items)
    @wishlist_item = WishlistItem.new(user: @user)
  end

  # displays the listings owned by the user
  def listings
    authorize! :read, @user
  end

  # purchase history for user
  def history
    # retrieves a paginated list of the current user's purchases
    @purchases = current_user.purchases.page params[:page]
  end

  # dashboard for logged-in users. displays the user's listings and wishlist
  def dashboard
    # displays the admin dashboard if current user is admin
    if current_user.is_admin
      # retrieves a list of all users, ordered by username
      @users = User.order("username")
      render :admin_dashboard
    # sold parameter can be toggled on the dashboard to display either sold or unsold listings
    elsif params[:sold]
      @sold = true
      # retrieves a paginated list of all of the users SOLD listings, ordered by date posted (descending)
      @listings = current_user.listings.where("is_sold is true").order("created_at desc").page params[:page]
    else
      @sold = false
      # retrieves a paginated list of all of the users UNSOLD listings, ordered by date posted (descending)
      @listings = current_user.listings.where("is_sold is false").order("created_at desc").page params[:page]
    end
  end

  private
    # gets the user object from the id parameter
    def set_user
      @user = User.find(params[:user_id])
    end
end
