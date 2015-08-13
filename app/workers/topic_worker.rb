class TopicWorker
  include Sidekiq::Worker
  require 'pusher'

  def perform(topic_id)
    topic = Topic.find(topic_id)
    topic.ny_times_articles = NyTimesWrapper.new.articles(topic)
    topic.wiki_text = WikiWrapper.new.wiki_text(topic)
    topic.tweets = TwitterWrapper.new(Pretendee.new).popular_tweets(topic)
    topic.save

    pusher = PusherWrapper.new
    channel_id = if topic.user
      topic.user.id.to_s
    else 
      topic.pretendee.user.id.to_s
    end
    pusher.client[channel_id].trigger("finished", {topic: topic})
  end

end