class ListingsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_listing, only: [:show, :edit, :update, :destroy]

  def index
    # search queries are redirected to the listings index
    # listings are displayed in accordance with the search query @q (the .includes method calls allow fields in related objects to be searched)
    # .where retrieves only unsold records
    # .page params[:page] returns the current page of listings (currently 10 listings per page)
    @listings = @q.result.includes(:genre).includes(:platform).includes(:user).where("is_sold is false").page params[:page]
  end

  def show
    authorize! :read, @listing

    if user_signed_in?
      # stripe session for purchasing a listing
      session = Stripe::Checkout::Session.create(
        payment_method_types: ['card'],
        customer_email: current_user.email,
        line_items: [{
          name: @listing.title,
          description: (@listing.description.blank? ? "no description" : @listing.description),
          amount: @listing.price.to_i * 100,
          currency: 'aud',
          quantity: 1,
        }],
        payment_intent_data: {
          metadata: {
            user_id: current_user.id,
            listing_id: @listing.id
          }
        },
        success_url: "#{root_url}payments/success?user_id=#{current_user.id}&listing_id=#{@listing.id}",
        cancel_url: "#{root_url}listings"
      )

      @session_id = session.id
    end
  end

  def new
    # initialises a blank listing for the current user
    @listing = Listing.new
    @listing.user = current_user
    authorize! :create, @listing
  end

  def create
    # initialises a listing for the current user with the submitted data
    @listing = Listing.new(listing_params)
    @listing.user = current_user
    authorize! :create, @listing
    @listing.user = current_user

    # saves the listing to the database (if valid)
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
    # updates the listing in the database with the submitted data (if valid)
    if @listing.update(listing_params)
      redirect_to @listing
    else
      render :edit
    end
  end

  def destroy
    authorize! :destroy, @listing
    # removes the listing from the database
    @listing.destroy
    redirect_to listings_path
  end

  # view for advanced search form
  def search
    @sort = [
      ["Date posted", "created_at desc"],
      ["Title", "title asc"],
      ["Price", "price asc"]
    ]
  end

  private
    # get listing from id in params
    def set_listing
      @listing = Listing.find(params[:id])
    end

    # permitted params for listing
    def listing_params
      return params.require(:listing).permit(:title, :description, :condition, :price, :is_sold, :platform_id, :genre_id, :image)
    end
end
