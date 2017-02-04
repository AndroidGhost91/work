class AddInstgramToUsers < ActiveRecord::Migration
  def change
    add_column :users, :social_link_instagram, :string
  end
end
