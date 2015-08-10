class Pretendee < ActiveRecord::Base
  belongs_to :user
  has_many :topics
  has_one :report
  
  validates :twitter, presence: true


  def get_recent_instagrams
    t = TwitterWrapper.new(self)
    i = InstagramWrapper.new

    if t.has_instagram? && i.public_instagram?(t.photo_id)
      insta_id = i.get_id(t.photo_id)
      instagram_pics = i.recent_instgrams(insta_id)
      update(instagram: i.insta_username(insta_id), instagram_photos: instagram_pics)
    end
    self.instagram_photos
  end

  def get_recent_tweets
    tweets = TwitterWrapper.new(self).recent_tweets
    update(tweets: tweets)
    self.tweets
  end

  def get_word_histogram
    words = TwitterWrapper.new(self).word_count_histogram
    update(word_histogram: words)
    self.word_histogram
  end
end
