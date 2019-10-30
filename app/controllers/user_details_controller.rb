class UserDetailsController < ApplicationController
  before_action :authenticate_user!

  def edit
  end

  def update
    if current_user.user_detail.update(user_params)
      redirect_to current_user, notice: "Profile updated successfully"
    else
      render :edit
    end
  end

  private
    def user_params
      params.require(:user_detail).permit(:bio, :avatar)
    end
end