class DropUserSegmentations < ActiveRecord::Migration
  def up
    drop_table :user_segmentations
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
