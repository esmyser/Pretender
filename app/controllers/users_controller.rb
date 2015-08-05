class UsersController < ApplicationController

  skip_before_action :login_required, only: :new

  def new
  end

  def show
  	@user = current_user
  end
  
  
  def show
    @user = current_user
  end

  def update
  	current_user.update(user_params)
    redirect_to(:back)
  end

  private
    def user_params
      params.require(:user).permit(:name, :email)
    end

end