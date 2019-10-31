class UserDetailsController < UserProfileController
  before_action :authenticate_user!
  before_action :set_user

  def edit
    authorize! :update, @user.user_detail
  end

  def update
    authorize! :update, @user.user_detail
    if @user.user_detail.update(user_params)
      redirect_to @user, notice: "Profile updated successfully"
    else
      render :edit
    end
  end

  private
    def user_params
      params.require(:user_detail).permit(:bio, :avatar)
    end
end