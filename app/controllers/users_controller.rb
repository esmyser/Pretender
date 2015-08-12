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
    if params['user']['report']['pretendee_id']
      @report = Report.new(:active => params['user']['report']['active'], :frequency => params['user']['report']['frequency'], :pretendee_id => params['user']['report']['pretendee_id'])
    else
      @report = Report.new(:active => params['user']['report']['active'], :frequency => params['user']['report']['frequency'], :topic_id => params['user']['report']['topic_id'])
    end

    @report.save
    UserMailer.welcome_email(current_user).deliver_now

    if params['user']['report']['pretendee_id'] 
      @pretendee = Pretendee.find(params['user']['report']['pretendee_id'])
      respond_to do |format|
        format.html {redirect_to user_pretendee_path(@user, @pretendee)}
        format.js
      end
    else
      @topic = Topic.find(params['user']['report']['topic_id'])
      respond_to do |format|
        format.html {redirect_to user_topic_path(@user, @topic)}
        format.js
      end
    end
    
  end

  private
    def user_params
      params.require(:user).permit(:name, :email)
    end

end