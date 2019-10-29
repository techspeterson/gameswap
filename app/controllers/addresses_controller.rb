class AddressesController < ApplicationController
  before_action :authenticate_user!

  def new
    @address = Address.new
    @address.user = current_user
  end

  def create
    @address = Address.new(address_params)
    @address.user = current_user

    if @address.save
      redirect_to current_user
    else
      render :new
    end
  end

  def edit
  end

  def update
    if current_user.address.update(address_params)
      redirect_to current_user
    else
      render :edit
    end
  end

  def destroy
    current_user.address.destroy
    redirect_to current_user
  end

  private
    def address_params
      params.require(:address).permit(:address_line_1, :address_line_2, :city, :state, :country_id, :postcode)
    end
end