class CreateSponsorLogo < ActiveRecord::Migration
  def change
    create_table :sponsor_logos do |t|
      t.string :image
      t.string :name
    end
  end
end
