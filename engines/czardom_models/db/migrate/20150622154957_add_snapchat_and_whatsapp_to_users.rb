class AddSnapchatAndWhatsappToUsers < ActiveRecord::Migration
  def change
    [:whatsapp, :snapchat].each do |social|
      add_column :users, "social_link_#{social}", :string
    end
  end
end
