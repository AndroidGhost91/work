class AddPriorityToEvents < ActiveRecord::Migration
  def change
    add_column :events, :priority, :integer, default: 50
  end
end
  