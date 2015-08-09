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
    @report = @pretendee.report || Report.new
    @user = current_user

    t = TwitterWrapper.new(@pretendee)
    i = InstagramWrapper.new

    @twitter_pics = t.recent_photos[0..7]
    @word_list = @pretendee.word_histogram || t.word_count_histogram

    if t.has_instagram?
      insta_id = i.get_id(t.photo_id)
      @instagram_pics = i.five_instagrams(insta_id)[0..7]
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