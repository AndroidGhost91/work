class AddNotificationByEmailToUsers < ActiveRecord::Migration
  def change
    add_column :users, :notification_by_email, :boolean, default: false
  end
end
