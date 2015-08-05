class Report < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.integer :frequency
      t.integer :pretendee_id

      t.timestamps null: false
    end
  end
end
