class PretendeesController < ApplicationController
  
  def new
    @user = current_user
  end

  def create
    @user = current_user
    @pretendee = @user.pretendees.build(pretendee_params)
    if @pretendee.save 
      redirect_to user_pretendee_path(current_user, @pretendee)
    else
      render :new
    end
  end

  def show
    @pretendee = Pretendee.find(params['id'])
    if @pretendee.report 
      @report = @pretendee.report 
    else
      @report = Report.new
    end
    @user = current_user
    t = TwitterWrapper.new(@pretendee)
    i = InstagramWrapper.new
    @pictures = t.recent_photos
    @word_list = t.word_count_histogram
    @topic = Topic.new

    # @instagram = i.five_instagrams(t.insta_id)

  end

  def update
    @pretendee = Pretendee.find(params['id'])
    @pretendee.update(pretendee_params)
    redirect_to user_pretendee_path(current_user, @pretendee)
  end

  def destroy
    @pretendee = Pretendee.find(params['id'])
    @pretendee.destroy
    redirect_to user_path(User.find(params['user_id']))
  end

  private
    def pretendee_params
      params.require(:pretendee).permit(:twitter, :user_id, :name)
    end

end