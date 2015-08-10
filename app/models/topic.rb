class Topic < ActiveRecord::Base
  belongs_to :pretendee
  belongs_to :user

end
