class RenameTitleToNameForUserSegments < ActiveRecord::Migration
  def up
    rename_column :user_segments, :title, :name
  end

  def down
    rename_column :user_segments, :name, :title
  end
end
