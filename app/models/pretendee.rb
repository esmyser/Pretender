class Pretendee < ActiveRecord::Base
  belongs_to :user
  has_many :topics
  has_many :reports
  
  validates :twitter, presence: true
end
