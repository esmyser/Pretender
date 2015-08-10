class AddTweetsToPretendee < ActiveRecord::Migration
  def change
    add_column :pretendees, :tweets, :hstore, array: true
  end
end
