class UserDetailsController < UsersController
  before_action :set_user, only: [:edit_profile, :update_profile]
  before_action :check_current_user, only: [:edit_profile, :update_profile]

  def edit_profile
  end

  def update_profile
    if @user.user_detail.update(user_params)
      redirect_to @user
    else
      render :edit
    end
  end

  private
    def user_params
      params.require(:user_detail).permit(:bio)
    end
end