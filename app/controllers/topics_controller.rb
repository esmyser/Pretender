class TopicsController < ApplicationController

  def new
    @topic = Topic.new
    @user = current_user
  end

  def create
    @user = current_user
    @topic = @user.topics.build(topic_params)
    if @topic.save 
      redirect_to user_topic_path(current_user, @topic)
    else
      render :new
    end
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
  end

end
