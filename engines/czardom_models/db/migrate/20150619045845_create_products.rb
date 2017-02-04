class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.integer :price
      t.string :permalink
      t.string :name

      t.timestamps
    end
  end
end
