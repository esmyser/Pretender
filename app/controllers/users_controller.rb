class UsersController < ApplicationController

  skip_before_action :login_required, only: :new

  def new
  end
  
  def show
    @user = current_user
  end

end