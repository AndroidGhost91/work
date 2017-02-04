# This migration comes from czardom_models_engine (originally 20150414224049)
class CreateUserSegmentations < ActiveRecord::Migration
  def change
    create_table :user_segmentations do |t|
      t.belongs_to :user, index: true
      t.belongs_to :user_segment, index: true

      t.timestamps
    end
  end
end
