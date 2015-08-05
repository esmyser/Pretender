class PretendeesController < ApplicationController
  
  def new
    @pretendee = Pretendee.new
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
    @report = Report.new
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
  end

  private
    def pretendee_params
      params.require(:pretendee).permit(:twitter, :user_id)
    end

end