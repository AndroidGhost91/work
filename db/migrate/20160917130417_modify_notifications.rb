class ModifyNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :checked, :boolean, default: false
    add_column :notifications, :attached_object_id, :integer, index: true
    add_column :notifications, :attached_object_type, :string
    add_column :notifications, :url, :string
    add_column :notifications, :description, :text
  end
end
