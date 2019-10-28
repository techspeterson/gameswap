class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @listing = Listing.find(params[:id])
      if !@listing
        redirect_to listings_path
      end
  end

  def edit
  end

  def update
  end
end
