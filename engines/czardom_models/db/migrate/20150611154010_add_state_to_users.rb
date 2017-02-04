class AddStateToUsers < ActiveRecord::Migration
  def up
    # remove location attributes
    remove_column :users, :city
    remove_column :users, :state

    # add state machine
    add_column :users, :state, :string, default: 'active'
    add_index :users, :state
  end

  def down
    # remove state machine
    remove_column :users, :state

    # add location attributes
    add_column :users, :city
    add_column :users, :state
  end
end
