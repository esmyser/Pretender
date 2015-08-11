class TopicsController < ApplicationController

  def create
    topic = Topic.new(topic_params)
    TopicPropertiesHydrator.new(topic)
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

    # if @topic.articles.empty?
    #   @topic.articles = NyTimesWrapper.articles(@topic.name)
    # end

    # if @topic.tweets.empty?
    #   @topic.tweets = TwitterWrapper.tweets(@topic.name)
    # end

    # if @topic.wiki_text.empty?
    #   @topic.wiki_text = WikiWrapper.wiki_text(@topic.name)
    # end
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
      params.require(:topic).permit(:name, :pretendee_id, :user_id, :ny_times_articles, :tweets, :wiki_text)
    end
end
