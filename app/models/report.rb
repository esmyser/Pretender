class Report < ActiveRecord::Base

  belongs_to :pretendee
  delegate :user, to: :pretendee

end