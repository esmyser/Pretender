class TopicWorker
  include Sidekiq::Worker

  def perform(topic_id)
    topic = Topic.find(topic_id)
    topic.ny_times_articles = NyTimesWrapper.new.articles(topic)
    topic.wiki_text = WikiWrapper.new.wiki_text(topic)
    topic.tweets = TwitterWrapper.new(Pretendee.new).popular_tweets(topic)
    topic.save
  end

end