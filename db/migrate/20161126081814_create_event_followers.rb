class CreateEventFollowers < ActiveRecord::Migration
  def change
    create_table :event_followers do |t|
      t.integer :event_id
      t.integer :user_id
    end
  end
end
