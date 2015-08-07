class Report < ActiveRecord::Base

  belongs_to :pretendee
  delegate :user, to: :pretendee

  validates_uniqueness_of :pretendee

  def self.active

    where(active: true)

  end

end