class AddApproximateLatitudeAndLongitude < ActiveRecord::Migration
  def change
    add_column :addresses, :approximate_latitude, :float
    add_column :addresses, :approximate_longitude, :float

    add_index :addresses, :approximate_latitude
    add_index :addresses, :approximate_longitude
  end
end
