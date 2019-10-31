class ListingsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_listing, only: [:show, :edit, :update, :destroy]

  def index
    @listings = Listing.all
  end

  def show
    authorize! :read, @listing
  end

  def new
    authorize! :create, Listing
    @listing = Listing.new
  end

  def create
    authorize! :create, Listing
    @listing = Listing.new(listing_params)
    @listing.user = current_user
    if @listing.save
      redirect_to @listing
    else
      render :new
    end
  end

  def edit
    authorize! :update, @listing
  end

  def update
    authorize! :update, @listing
    if @listing.update(listing_params)
      redirect_to @listing
    else
      render :edit
    end
  end

  def destroy
    authorize! :destroy, @listing
    @listing.destroy
    redirect_to listings_path
  end

  private
    def set_listing
      @listing = Listing.find(params[:id])
    end

    def set_user_listing
      @listing = current_user.listings.find(params[:id])
      if !@listing
        redirect_to listings_path
      end
    end

    def listing_params
      return params.require(:listing).permit(:title, :description, :condition, :price, :is_sold, :platform_id, :genre_id, :image)
    end
end
