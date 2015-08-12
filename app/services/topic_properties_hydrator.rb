class TopicPropertiesHydrator
  include ActiveModel::Model

  def initialize(topic_id)
    TopicWorker.perform_async(topic_id)
  end

end