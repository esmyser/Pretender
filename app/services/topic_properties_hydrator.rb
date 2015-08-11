class TopicPropertiesHydrator
  include ActiveModel::Model

  attr_accessor :ny_times_articles, :wiki_text, :tweets

  def initialize(topic)
    topic.ny_times_articles = NyTimesWrapper.new.articles(topic)
    topic.wiki_text = WikiWrapper.new.wiki_text(topic)
    topic.tweets = TwitterWrapper.new(Pretendee.new).popular_tweets(topic)
    topic.save
  end

end