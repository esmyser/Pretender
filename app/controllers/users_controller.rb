class UsersController < ApplicationController
  def new
 	  render :new
  end

  def show
  	@user = current_user
  end
  
end