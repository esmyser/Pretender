class Pretendee < ActiveRecord::Base
  belongs_to :user
  has_many :topics
  has_one :report
  
  validates :twitter, presence: true

  def profile_image_url
    "https://twitter.com/" + twitter.gsub(' ', '') + "/profile_image?size=original"
  end

  def first_name
    name.split.first
  end
end
