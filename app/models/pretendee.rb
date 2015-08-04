class Pretendee < ActiveRecord::Base
  belongs_to :user
  has_many :topics
  validates :twitter, presence: true
end
