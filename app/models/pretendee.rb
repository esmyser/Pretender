class Pretendee < ActiveRecord::Base
  belongs_to :user
  has_many :topics
  has_one :report
  
  validates :twitter, presence: true
end
