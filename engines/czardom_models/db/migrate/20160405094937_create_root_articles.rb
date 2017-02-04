class CreateRootArticles < ActiveRecord::Migration
  def change
    create_table :root_articles do |t|
      t.string :title
      t.string :media
      t.text :body
      t.integer :slide_id, index: true
      t.timestamps null: false
    end
  end
end
