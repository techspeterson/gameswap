class ListingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_listing, only: [:show]
  before_action :set_user_listing, only: [:edit, :update, :destroy]

  def index
    @listings = Listing.all
  end

  def show
  end

  def new
    @listing = Listing.new
  end

  def create
    @listing = current_user.listings.create(listing_params)
    if @listing.save
      redirect_to @listing
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @listing.update(listing_params)
      redirect_to @listing
    else
      render :edit
    end
  end

  def destroy
    @listing.destroy
    redirect_to listings_path
  end

  private
    def set_listing
      @listing = Listing.find(params[:id])
      if !@listing
        redirect_to listings_path
      end
    end

    def set_user_listing
      @listing = current_user.listings.find(params[:id])
      if !@listing
        redirect_to listings_path
      end
    end

    def listing_params
      return params.require(:listing).permit(:title, :description, :condition, :price, :is_sold, :platform_id, :genre_id)
    end
end
