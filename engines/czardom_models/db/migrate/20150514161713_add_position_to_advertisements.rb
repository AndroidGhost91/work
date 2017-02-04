class AddPositionToAdvertisements < ActiveRecord::Migration
  def change
    add_column :advertisements, :position, :string, default: ''
    add_index :advertisements, :position
  end
end
