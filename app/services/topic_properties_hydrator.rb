class TopicPropertiesHydrator
  include ActiveModel::Model

  attr_accessor :ny_times_articles, :wiki_text, :tweets

  def initialize(topic)
    TopicWorker.perform_async(topic)
  end

end