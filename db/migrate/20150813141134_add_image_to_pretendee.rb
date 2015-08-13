class AddImageToPretendee < ActiveRecord::Migration
  def change
    add_column :pretendees, :image, :string
  end
end
