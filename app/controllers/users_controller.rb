class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:edit_profile, :update, :update_profile]

  def show
    @user = User.find(params[:id])
    if !@user
      redirect_to root_path
    end
  end

  def edit_profile
  end

  # def update
  #   if @user.user_detail.update(user_params)
  #     redirect_to @user
  #   else
  #     render :edit
  #   end
  # end

  def update_profile
    if @user.user_detail.update(user_params)
      redirect_to @user
    else
      render :edit
    end
  end

  private

    def set_user
      @user = User.find(params[:id])
      if @user != current_user
        redirect_to root_path
      end
    end

    def user_params
      temp_params = params.require(:user_detail).permit(:bio)
      # return temp_params[:user_detail_attributes]
    end

    def address_params
      temp_params = params.require(:user).permit(address_attributes: [:address_line_1, :address_line_2, :city, :state, :country_id, :postcode])
      return temp_params[:address_attributes]
    end
end
