class AddPathToSponsorLogos < ActiveRecord::Migration
  def change
    add_column :sponsor_logos, :path, :string
  end
end
