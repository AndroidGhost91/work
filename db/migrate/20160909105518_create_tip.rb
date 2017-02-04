class CreateTip < ActiveRecord::Migration
  def change
    create_table :tips do |t|
      t.text :content, null: false

      t.timestamps null: false
    end

    add_index :tips, :content
  end
end
