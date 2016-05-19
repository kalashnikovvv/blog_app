class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.text :text
      t.boolean :visible, default: true, null: false
      t.date :publish_date, null: false
      t.belongs_to :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
