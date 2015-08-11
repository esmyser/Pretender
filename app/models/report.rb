class Report < ActiveRecord::Base

  belongs_to :pretendee
  delegate :user, to: :pretendee
  validates_uniqueness_of :pretendee, :allow_blank => true

  belongs_to :topic
  delegate :user, to: :topic
  validates_uniqueness_of :topic, :allow_blank => true

  def active?
    self.active == true
  end

  def inactive?
    self.active == false
  end

  def self.every_day_pretendee
    where(frequency: 1, active: true, topic_id: nil)
  end

  def self.every_three_days_pretendee
    where(frequency: 3, active: true, topic_id: nil)
  end

  def self.every_week_pretendee
    where(frequency: 7, active: true, topic_id: nil)
  end

  def self.every_day_topic
    where(frequency: 1, active: true, pretendee_id: nil)
  end

  def self.every_three_days_topic
    where(frequency: 3, active: true, pretendee_id: nil)
  end

  def self.every_week_topic
    where(frequency: 7, active: true, pretendee_id: nil)
  end

end