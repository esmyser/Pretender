class AddWordHistogramToPretendee < ActiveRecord::Migration
  def change
    add_column :pretendees, :word_histogram, :hstore, array: true
  end
end
