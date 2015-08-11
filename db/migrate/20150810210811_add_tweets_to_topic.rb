class AddTweetsToTopic < ActiveRecord::Migration
  def change
    add_column :topics, :tweets, :hstore, array: true

  end
end
