class AddRedirectPathToProducts < ActiveRecord::Migration
  def change
    add_column :products, :redirect_path, :string
  end
end
