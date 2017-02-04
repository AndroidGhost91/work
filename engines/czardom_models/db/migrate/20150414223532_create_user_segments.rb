class CreateUserSegments < ActiveRecord::Migration
  def change
    create_table :user_segments do |t|
      t.integer :position
      t.string :title
      t.string :ancestry

      t.timestamps
    end

    add_index :user_segments, :position
    add_index :user_segments, :ancestry
  end
end
