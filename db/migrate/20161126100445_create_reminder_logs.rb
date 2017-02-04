class CreateReminderLogs < ActiveRecord::Migration
  def change
    create_table :reminder_logs do |t|
      t.string :log_type  # Event, or somethingelse
      t.integer :object_id # event_id...
      t.string :object_type ## Event... or somethingelse
      t.integer :user_id
      t.datetime :time_sent
      t.text :log
    end
  end
end
