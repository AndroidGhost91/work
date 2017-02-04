class AddMoreSocialNetworksToUsers < ActiveRecord::Migration
  def change
    [:vine, :youtube, :tumblr, :custom_facebook_url].each do |social|
      add_column :users, "social_link_#{social}", :string
    end
  end
end
