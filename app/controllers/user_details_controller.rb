class UserDetailsController < UserProfileController
  before_action :authenticate_user!
  before_action :set_user

  # user detail routes have user id passed in as a parameter
  # those with the required permissions (the user in question, or an admin user) can access it

  def edit
    authorize! :update, @user.user_detail
  end

  def update
    authorize! :update, @user.user_detail

    if @user.user_detail.update(user_params)
      redirect_to user_profile_path(@user), notice: "Profile updated successfully"
    else
      render :edit
    end
  end

  private
    # params for user detail
    def user_params
      params.require(:user_detail).permit(:bio, :avatar)
    end
end