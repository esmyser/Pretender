class AddWikiTextToTopic < ActiveRecord::Migration
  def change
    add_column :topics, :wiki_text, :hstore
  end
end
