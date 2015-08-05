class AddReportToPretendee < ActiveRecord::Migration
  def change
    add_column :pretendees, :report, :boolean, default: false
  end
end
