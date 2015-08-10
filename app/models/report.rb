class Report < ActiveRecord::Base

  belongs_to :pretendee
  delegate :user, to: :pretendee

  validates_uniqueness_of :pretendee

  belongs_to :topic
  delegate :user, to: :topic

  validates_uniqueness_of :topic

  def self.every_day 
    where(frequency: 1, active: true)
  end

  def self.every_three_days
    where(frequency: 3, active: true)
  end

  def self.every_week
    where(frequency: 7, active: true)
  end

end