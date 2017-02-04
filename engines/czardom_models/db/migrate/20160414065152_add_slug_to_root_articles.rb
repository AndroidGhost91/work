class AddSlugToRootArticles < ActiveRecord::Migration
  def change
    add_column :root_articles, :slug, :string
    add_index :root_articles, :slug, unique: true
  end
end
