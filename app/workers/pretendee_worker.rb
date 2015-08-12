class PretendeeWorker
  include Sidekiq::Worker

  def perform(pretendee_id)
    pretendee = Pretendee.find(pretendee_id)
    twitter_wrapper = TwitterWrapper.new(pretendee)
    instagram_wrapper = InstagramWrapper.new

    pretendee.name = twitter_wrapper.get_name
    pretendee.tweets = twitter_wrapper.recent_tweets
    pretendee.word_histogram = twitter_wrapper.word_count_histogram
    greatest_weight = pretendee.word_histogram.first['weight'].to_i + 20
    pretendee.word_histogram.unshift({text: pretendee.name, weight: greatest_weight})
    insta_id = instagram_wrapper.get_id(twitter_wrapper.photo_id)
    pretendee.instagram_photos = instagram_wrapper.recent_instgrams(insta_id) if insta_id
    pretendee.save
  end
end
