class UsersController < ApplicationController

  skip_before_action :login_required, only: :new

  def new
  end

  def show
  	@user = current_user
  end
  
  def update
    @user = User.find(params['id'])
    @user.update(user_params)
    redirect_to :show
  end

  private
    def user_params
      params.require(:user).permit(:email)
    end

end