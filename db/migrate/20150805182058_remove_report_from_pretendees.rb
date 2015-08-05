class RemoveReportFromPretendees < ActiveRecord::Migration
  def change
    remove_column :pretendees, :report
  end
end
