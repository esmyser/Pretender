class AddTopicToReport < ActiveRecord::Migration
  def change
    add_column :reports, :topic_id, :integer
  end
end
