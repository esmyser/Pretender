class AddWordHistogramToPretendee < ActiveRecord::Migration
  def change
    add_column :pretendees, :word_histogram, :hstore, default: {}, null: false
  end
end
