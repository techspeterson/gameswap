class PaymentsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:webhook]

  # the page redirected to upon making a payment
  # displays details of purchased listing
  def success
    # retrieves the user with the given id (to make sure it matches the current user in case the page is accessed through some unintended means)
    @user = User.find(params[:user_id])
    if @user != current_user
      redirect_to listings_path
    end
    # retrieves the listing with the given id
    @listing = Listing.find(params[:listing_id])
  end

  # webhook sets listing's is_sold to true when the listing is purchased
  def webhook
    payment_id= params[:data][:object][:payment_intent]
    payment = Stripe::PaymentIntent.retrieve(payment_id)
    listing_id = payment.metadata.listing_id
    user_id = payment.metadata.user_id

    # retrieves the listing with the id passed in through payment metadata
    listing = Listing.find(listing_id)
    listing.is_sold = true
    listing.save

    # creates a purchase record for the given user and listing
    Purchase.create(user_id: user_id, listing: listing)

    status 200
  end
end