class CreateSpecialOffers < ActiveRecord::Migration
  def change
    create_table :special_offers do |t|
      t.text :content, null: false

      t.timestamps null: false
    end
  end
end
