class AddBooleanToReports < ActiveRecord::Migration
  def change    
    add_column :reports, :active, :boolean, default: false
  end
end
