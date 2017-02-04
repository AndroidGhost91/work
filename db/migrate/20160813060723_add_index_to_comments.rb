class AddIndexToComments < ActiveRecord::Migration
  def change
    add_index :comments, [:user_id, :commentable_id] , :unique => true
  end
end
