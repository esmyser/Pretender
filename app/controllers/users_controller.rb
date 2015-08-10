class UsersController < ApplicationController

  skip_before_action :login_required, only: :new

  def new
  end

  def show
  	@user = current_user

    if @user.pretendees.present?
      @pretendees = @user.pretendees
    end

    if @user.topics.present?
      @topics = @user.topics
    end
  end
  
  def update
    @user = current_user
    @user.update(user_params)
    @report = Report.new(:active => params['user']['report']['active'], :frequency => params['user']['report']['frequency'], :pretendee_id => params['user']['report']['pretendee_id'])
    @report.save
    UserMailer.welcome_email(current_user).deliver_now
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