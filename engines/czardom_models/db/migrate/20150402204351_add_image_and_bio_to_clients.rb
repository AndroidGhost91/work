class AddImageAndBioToClients < ActiveRecord::Migration
  def change
    add_column :user_clients, :image, :string
    add_column :user_clients, :bio, :text
  end
end
