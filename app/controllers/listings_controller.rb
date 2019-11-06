class ListingsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_listing, only: [:show, :edit, :update, :destroy]

  def index
    # search queries are redirected to the listings index
    # listings are displayed in accordance with the search query @q
    @q.sorts = "created_at desc" if @q.sorts.empty?
    @listings = @q.result.includes(:genre).includes(:platform).where("is_sold is false")
  end

  def show
    authorize! :read, @listing
    # stripe session for purchasing a listing
    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      customer_email: current_user.email,
      line_items: [{
        name: @listing.title,
        description: @listing.description,
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

  def new
    # initialises a blank listing
    @listing = Listing.new
    authorize! :create, @listing
  end

  def create
    # creates a listing for the current user with the submitted params (if valid)
    @listing = Listing.new(listing_params)
    authorize! :create, @listing
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

  # view for advanced search form
  def search
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
