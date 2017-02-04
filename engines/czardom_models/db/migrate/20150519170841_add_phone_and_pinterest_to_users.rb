class AddPhoneAndPinterestToUsers < ActiveRecord::Migration
  def change
    add_column :users, :phone_number, :string
    add_column :users, :pinterest_username, :string
  end
end
