class AddInstagramPhotosToPretendee < ActiveRecord::Migration
  def change
    add_column :pretendees, :instagram_photos, :hstore, array: true
  end
end