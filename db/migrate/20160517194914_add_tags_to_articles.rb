class AddTagsToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :tags, :string, array: true, default: "{}"
    add_index :articles, :tags, using: "gin"
  end
end
