class TopicsController < ApplicationController

  def create
    topic = Topic.new(topic_params)
    topic.image = SuckrWrapper.new.google_image_url_for_phrase(topic.name)
    topic.save
    TopicPropertiesHydrator.new(topic.id)

    respond_to do |format|
      format.html { topic.save ? (redirect_to user_topic_path(current_user, topic)) : (render :new) }
      format.js { }
    end
  end

  def new
    @topic = Topic.new
    @user = current_user
  end

  def show
    @topic = Topic.find(params['id'])
    @user = User.find(params["user_id"])
    @report = @topic.report || Report.new
  end

  def update
    @topic = Topic.find(params['id'])
    @topic.update(topic_params)
  end

  def destroy
    @topic = Topic.find(params['id'])
    @topic.destroy

    respond_to do |format|
      format.html {redirect_to(:back)}
      format.js{}
    end
  end

  private
    def topic_params
      params.require(:topic).permit(:name, :pretendee_id, :user_id, :ny_times_articles, :tweets, :wiki_text, :image)
    end
end
