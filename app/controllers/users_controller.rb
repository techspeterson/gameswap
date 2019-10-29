class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit_profile, :update_profile, :add_wishlist_item, :remove_wishlist_item, :edit_address]
  before_action :check_current_user, only: [:edit_profile, :update_profile, :add_wishlist_item, :remove_wishlist_item, :edit_address]

  def show
    if !@user
      redirect_to root_path
    end

    @wishlist_item = WishlistItem.new
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

    def check_current_user
      if @user != current_user
        redirect_to @user
      end
    end

end
