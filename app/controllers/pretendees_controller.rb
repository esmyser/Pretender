class PretendeesController < ApplicationController
  
  def new
    @user = current_user
  end

  def create
    @user = current_user
    @pretendee = @user.pretendees.build(pretendee_params)
    if @pretendee.save 
      @pretendee.update(name: TwitterWrapper.new(@pretendee).get_name)
      redirect_to user_pretendee_path(current_user, @pretendee)
    else
      render :new
    end
  end

  def show
    @pretendee = Pretendee.find(params['id'])
    @topic = Topic.new
    @user = current_user
    @report = @pretendee.report || Report.new
    @tweets = @pretendee.tweets || @pretendee.get_recent_tweets
    @word_list = @pretendee.word_histogram || @pretendee.get_word_histogram
    @instagram_pics = @pretendee.instagram_photos || @pretendee.get_recent_instagrams

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