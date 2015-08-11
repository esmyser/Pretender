class AddNyTimesArticlesToTopic < ActiveRecord::Migration
  def change
    add_column :topics, :ny_times_articles, :hstore, array: true
  end
end
