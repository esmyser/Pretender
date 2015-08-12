class TopicWorker
  include Sidekiq::Worker
  require 'pusher'

  def perform(topic_id)
    topic = Topic.find(topic_id)
    topic.ny_times_articles = NyTimesWrapper.new.articles(topic)
    topic.wiki_text = WikiWrapper.new.wiki_text(topic)
    topic.tweets = TwitterWrapper.new(Pretendee.new).popular_tweets(topic)
    topic.save

    Pusher.url = "https://01e0b165f94105952d85:2d714e5fb2468fd05eec@api.pusherapp.com/apps/135145"
    Pusher["whatever"].trigger("finished", {topic: topic})
      # is the data just @topic? —> will be converted to json
      # it should just be a hash:
      # {:topic => @topic}
  end

end