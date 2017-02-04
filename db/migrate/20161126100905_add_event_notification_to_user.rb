class AddEventNotificationToUser < ActiveRecord::Migration
  def change
    add_column :users, :event_notification, :boolean, default: true
  end
end
