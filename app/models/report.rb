class Report < ActiveRecord::Base

  belongs_to :pretendee
  delegate :user, to: :pretendee

  def report_on?
    self.pretendee.report
  end

end