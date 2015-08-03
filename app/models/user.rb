class User < ActiveRecord::Base
  has_many :pretendees
  has_many :topics, through: :pretendees
end
