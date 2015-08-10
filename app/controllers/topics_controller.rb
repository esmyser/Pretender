class TopicsController < ApplicationController

  def create
    topic = Topic.new(topic_params)
    topic.save ? (redirect_to user_topic_path(current_user, topic)) : (render :new)
  end

  def new
    @topic = Topic.new
    @user = current_user
  end

  def show
    @topic = Topic.find(params['id'])
    @user = User.find(params["user_id"])
    @report = @topic.report || Report.new
    w = WikiWrapper.new
    @paragraph = w.first_paragraph(@topic)
    @url = w.get_url(@topic)
    @articles = NyTimesWrapper.new.articles(@topic)
    @client = TwitterWrapper.new(current_user)
    @tweets = @client.popular_tweets_oembeds(@topic.name)
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
      params.require(:topic).permit(:name, :pretendee_id, :user_id)
    end
end
