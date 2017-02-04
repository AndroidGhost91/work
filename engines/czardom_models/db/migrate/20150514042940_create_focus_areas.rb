class CreateFocusAreas < ActiveRecord::Migration
  def change
    create_table :focus_areas do |t|
      t.string :name
      t.string :position

      t.timestamps
    end
    add_index :focus_areas, :position
  end
end
