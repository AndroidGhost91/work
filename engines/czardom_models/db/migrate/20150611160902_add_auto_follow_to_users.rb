class AddAutoFollowToUsers < ActiveRecord::Migration
  def change
    add_column :users, :auto_follow, :boolean, default: false
  end
end
