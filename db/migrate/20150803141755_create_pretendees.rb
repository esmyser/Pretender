class CreatePretendees < ActiveRecord::Migration
  def change
    create_table :pretendees do |t|
      t.string :name
      t.string :twitter
      t.string :instagram
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
