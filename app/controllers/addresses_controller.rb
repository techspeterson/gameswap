class AddressesController < UserProfileController
  before_action :authenticate_user!
  before_action :set_user

  # address routes have user id passed in as a parameter
  # those with the required permissions (the user in question, or an admin user) can access it

  def new
    # generates a blank address for the user the address will belong to
    @address = Address.new
    @address.user = @user
    authorize! :create, @user.address
  end

  def create
    # generates an address for the given user with the given params
    @address = Address.new(address_params)
    @address.user = @user
    authorize! :create, @user.address

    if @address.save
      redirect_to user_profile_path(@user), notice: "Address added successfully"
    else
      render :new
    end
  end

  def edit
    authorize! :update, @user.address
  end

  def update
    authorize! :update, @user.address

    if @user.address.update(address_params)
      redirect_to user_profile_path(@user), notice: "Address updated successfully"
    else
      render :edit
    end
  end

  def destroy
    authorize! :destroy, @user.address
    @user.address.destroy
    redirect_to user_profile_path(@user), notice: "Address deleted successfully"
  end

  private
    # permitted params for address: address lines, city, state, country, postcode
    def address_params
      params.require(:address).permit(:address_line_1, :address_line_2, :city, :state, :country_id, :postcode)
    end
end