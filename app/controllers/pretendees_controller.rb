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
    @user = current_user
    @pretendee = Pretendee.find(params['id'])
    t = TwitterWrapper.new(@pretendee)
    @word_list = t.word_count_histogram
    @topic = Topic.new
  end

  def update
    @pretende = Pretendee.find(params['id'])
    @pretendee.update(pretendee_params)
  end

  def destroy
    @pretendee = Pretendee.find(params['id'])
    @pretendee.destroy
    redirect_to user_path(User.find(params['user_id']))
  end

  def report
    @pretendee = Pretendee.find(params['pretendee_id'])
  end

  private
    def pretendee_params
      params.require(:pretendee).permit(:twitter, :user_id, :name)
    end

end