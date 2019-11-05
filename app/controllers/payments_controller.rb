class PaymentsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:webhook]

  def success
    @user = User.find(params[:user_id])
    if @user != current_user
      redirect_to listings_path
    end
    @listing = Listing.find(params[:listing_id])
  end

  def webhook
    payment_id= params[:data][:object][:payment_intent]
    payment = Stripe::PaymentIntent.retrieve(payment_id)
    listing_id = payment.metadata.listing_id
    user_id = payment.metadata.user_id

    listing = Listing.find(listing_id)
    listing.is_sold = true
    listing.save

    p "listing id " + listing_id
    p "user id " + user_id

    status 200
  end
end