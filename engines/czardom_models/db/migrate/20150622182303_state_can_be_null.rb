class StateCanBeNull < ActiveRecord::Migration
  def change
    change_column :addresses, :state, :string, null: true
  end
end
