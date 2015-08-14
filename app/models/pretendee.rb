class Pretendee < ActiveRecord::Base
  belongs_to :user
  has_many :topics
  has_one :report
  
  validates :twitter, presence: true
  validate :pretendee_must_be_valid_twitter_handle

  def profile_image_url
    "https://twitter.com/" + twitter.gsub(' ', '') + "/profile_image?size=original"
  end

  def first_name
    name.split.first
  end

  def pretendee_must_be_valid_twitter_handle
    
    begin 
      TwitterWrapper.new(self).get_name
    rescue Twitter::Error::NotFound
      errors.add(:twitter, "#{self.twitter} is not a valid twitter handle")
      # binding.pry
    ensure
      # we can add anything we want to make sure will execute here
    end
  end

end