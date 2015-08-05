class TopicsController < ApplicationController

  def create
    @user = current_user
    @topic = @user.topics.build(topic_params)
    if @topic.save 
      redirect_to user_topic_path(current_user, @topic)
    else
      render :new
    # @user = User.find(params[:user_id])
    # @pretendee = Pretendee.find(params[:pretendee_id])
    # @topic = @pretendee.topics.build(topic_params)
    # if @topic.save
    #   redirect_to user_pretendee_path(@user, @pretendee)
    end
  end

  def new
    @topic = Topic.new
    @user = current_user
  end

  def show
    @topic = Topic.find(params['id'])
  end

  def update
    @topic = Topic.find(params['id'])
    @topic.update(topic_params)
  end

  def destroy
    @topic = Topic.find(params['id'])
    @topic.destroy
    redirect_to(:back)
  end

  private
    def topic_params
      params.require(:topic).permit(:name, :pretendee_id)
    end
end
