class CreateUserFocusAreas < ActiveRecord::Migration
  def change
    create_table :user_focus_areas do |t|
      t.belongs_to :user, index: true
      t.belongs_to :focus_area, index: true

      t.timestamps
    end
  end
end
