class AddressesController < UserProfileController
  before_action :authenticate_user!
  before_action :set_user

  def new
    authorize! :create, Address
    @address = Address.new
    @address.user = @user
  end

  def create
    authorize! :create, Address
    @address = Address.new(address_params)
    @address.user = @user

    if @address.save
      redirect_to @user
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
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    authorize! :destroy, @user.address
    @user.address.destroy
    redirect_to @user
  end

  private
    def address_params
      params.require(:address).permit(:address_line_1, :address_line_2, :city, :state, :country_id, :postcode)
    end
end