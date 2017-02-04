class AddMediaToForemPosts < ActiveRecord::Migration
  def change
    add_column :forem_posts, :media, :string
  end
end
