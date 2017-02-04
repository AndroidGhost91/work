class AddPrimaryAndSecondarySegmentsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :primary_segment_id, :integer
    add_column :users, :secondary_segment_id, :integer

    add_index :users, :primary_segment_id
    add_index :users, :secondary_segment_id
  end
end
