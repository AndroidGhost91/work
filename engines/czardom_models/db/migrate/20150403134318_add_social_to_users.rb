class AddSocialToUsers < ActiveRecord::Migration
  def change
    add_column :users, :twitter_username, :string
    add_column :users, :linked_in, :string
    add_column :users, :google_plus_id, :string
  end
end
