class UsersController < ApplicationController

  skip_before_action :login_required, only: :new

  def new
  end

  def show
  	@user = current_user
  end
  
  def update
    @user = current_user
    @user.update(user_params)
    @report = Report.new(:active => params['user']['report']['active'], :frequency => params['user']['report']['frequency'], :pretendee_id => params['user']['report']['pretendee_id'])
    binding.pry
    @report.save
    binding.pry
    if @user.pretendees
      @pretendee = Pretendee.find(params['user']['report']['pretendee_id'])
    end
    redirect_to user_pretendee_path(@user, @pretendee)
  end

  private
    def user_params
      params.require(:user).permit(:name, :email)
    end

end