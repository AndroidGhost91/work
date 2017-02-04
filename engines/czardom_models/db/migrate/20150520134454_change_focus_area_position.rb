class ChangeFocusAreaPosition < ActiveRecord::Migration
  def up
    remove_column :focus_areas, :position
    add_column :focus_areas, :position, :integer
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
