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
    @topic = Topic.new
    
    @user = current_user
    @report = @pretendee.report || Report.new
    
    twitter = TwitterWrapper.new(@pretendee)
    
    @twitter_pics = twitter.recent_photos
    @word_list = @pretendee.word_histogram || twitter.word_count_histogram

    if twitter.has_instagram?
      instagram = InstagramWrapper.new
      insta_id = instagram.get_id(twitter.photo_id)
      @instagram_pics = instagram.five_instagrams(insta_id)[0..7]
    end
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