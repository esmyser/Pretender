class TopicsController < ApplicationController

  def create
    @user = User.find(params[:user_id])
    @pretendee = Pretendee.find(params[:pretendee_id])
    @topic = @pretendee.topics.build(topic_params)
    if @topic.save
      redirect_to user_pretendee_path(@user, @pretendee)
    else
      render :new
    end
  end

  private
    def topic_params
      params.require(:topic).permit(:name, :pretendee_id)
    end


end
