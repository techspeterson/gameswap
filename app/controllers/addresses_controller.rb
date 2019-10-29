class AddressesController < UsersController
  before_action :set_user, only: [:edit_address]
  before_action :check_current_user, only: [:edit_address]

  def new_address
    @address = Address.new
  end

  def create_address
  end

  def edit_address
    @address = @user.address
  end

  def update_address
  end

  private
    def address_params
      params.require(:address).permit(:address_line_1, :address_line_2, :city, :state, :country_id, :postcode)
    end
end